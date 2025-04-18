// Created for Umpa in 2025

import AuthenticationServices
import Combine
import Domain
import Factory
import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Mockable
import NidThirdPartyLogin
import SwiftUI
import Utility

enum LoginInteractorError: LocalizedError {
    enum KakaoLoginFailedReason {
        case missingOauthToken
    }

    case kakaoLoginFailed(KakaoLoginFailedReason)
}

@MainActor
protocol LoginInteractor {
    func loginWithApple(with authorizationController: AuthorizationController)
    func loginWithKakao()
    func loginWithNaver()
    func loginWithGoogle()
}

struct LoginInteractorImpl {
    let appState: AppState
    let useCase: UseCase

    let cancelBag = CancelBag()

    init(
        appState: AppState,
        useCase: UseCase
    ) {
        self.appState = appState
        self.useCase = useCase

        #if DEBUG
        if let mockUseCase = useCase as? MockUseCase {
            given(mockUseCase)
                .checkAccountLinkedSocialId(with: .matching { data in
                    data.socialLoginType == .kakao
                })
                .willReturn(
                    Just(Student.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .checkAccountLinkedSocialId(with: .matching { data in
                    data.socialLoginType == .naver
                })
                .willReturn(
                    Just(nil)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .checkAccountLinkedSocialId(with: .matching { data in
                    data.socialLoginType == .google
                })
                .willReturn(
                    Just(Teacher.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
        #endif
    }
}

extension LoginInteractorImpl: LoginInteractor {
    func loginWithApple(with authorizationController: AuthorizationController) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        Task {
            let result = try await authorizationController.performRequest(request)
            switch result {
            case .appleID(let appleIDCredential):
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let email = appleIDCredential.email

                let socialIdData = SocialIdData(socialLoginType: .apple)
                tryUmpaLogin(with: socialIdData)
                    .store(in: cancelBag)
            default:
                assertionFailure()
            }
        } catch: { _ in
            // TODO: Handle error
        }
    }

    func loginWithKakao() {
        Task {
            let oauthToken = try await _loginWithKakao()
            print(oauthToken.idToken)

            let socialIdData = SocialIdData(socialLoginType: .kakao)
            tryUmpaLogin(with: socialIdData)
                .store(in: cancelBag)
        } catch: { error in
            print(error)
        }
    }

    func loginWithNaver() {
        Task {
            let loginResult = try await NidOAuth.shared.requestLogin()
            let accessToken = loginResult.accessToken.tokenString
            let profileResult = try await NidOAuth.shared.getUserProfile(accessToken: accessToken)
            let id = profileResult["id"]
            print("Id: ", id)

            let socialIdData = SocialIdData(socialLoginType: .naver)
            tryUmpaLogin(with: socialIdData)
                .store(in: cancelBag)
        } catch: { error in
            print("Error: ", error.localizedDescription)
        }
    }

    func loginWithGoogle() {
        let socialIdData = SocialIdData(socialLoginType: .google)
        tryUmpaLogin(with: socialIdData)
            .store(in: cancelBag)
    }
}

extension LoginInteractorImpl {
    @MainActor
    private func _loginWithKakao() async throws -> OAuthToken {
        if UserApi.isKakaoTalkLoginAvailable() {
            return try await withCheckedThrowingContinuation { continuation in
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }
                    guard let oauthToken else {
                        continuation.resume(throwing: LoginInteractorError.kakaoLoginFailed(.missingOauthToken))
                        return
                    }
                    continuation.resume(returning: oauthToken)
                }
            }
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }
                    guard let oauthToken else {
                        continuation.resume(throwing: LoginInteractorError.kakaoLoginFailed(.missingOauthToken))
                        return
                    }
                    continuation.resume(returning: oauthToken)
                }
            }
        }
    }

    @MainActor
    private func tryUmpaLogin(with socialIdData: SocialIdData) -> AnyCancellable {
        useCase.checkAccountLinkedSocialId(with: socialIdData)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { [appState] user in
                if let user {
                    appState.userData.login.currentUser = user
                    switch user.userType {
                    case .student:
                        appState.routing.currentTab = .teacherFinder
                    case .teacher:
                        appState.routing.currentTab = .teacherHome
                    }
                } else {
                    appState.routing.loginNavigationPath.append(socialIdData.socialLoginType)
                }
            }
    }
}

// MARK: - NidOAuth + Swift Concurrency

extension NidOAuth {
    @MainActor
    func requestLogin() async throws -> LoginResult {
        return try await withCheckedThrowingContinuation { continuation in
            requestLogin { result in
                switch result {
                case .success(let loginResult):
                    continuation.resume(returning: loginResult)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    @MainActor
    func getUserProfile(accessToken: String) async throws -> [String: String] {
        return try await withCheckedThrowingContinuation { continuation in
            getUserProfile(accessToken: accessToken) { result in
                switch result {
                case .success(let profileResult):
                    continuation.resume(returning: profileResult)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
