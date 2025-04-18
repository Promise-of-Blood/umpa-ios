// Created for Umpa in 2025

import AuthenticationServices
import Combine
import Domain
import Factory
import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Mockable
import SwiftUI
import Utility

enum LoginInteractorError: LocalizedError {
    enum KakaoLoginFailedReason {
        case missingOauthToken
    }

    case kakaoLoginFailed(KakaoLoginFailedReason)
}

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
            let (oauthToken, error) = await _loginWithKakao()

            if let error = error {
                throw error
            }

            guard let oauthToken else {
                throw LoginInteractorError.kakaoLoginFailed(.missingOauthToken)
            }

            print(oauthToken.idToken)

            let socialIdData = SocialIdData(socialLoginType: .kakao)
            tryUmpaLogin(with: socialIdData)
                .store(in: cancelBag)
        } catch: { error in
            print(error)
        }
    }

    func loginWithNaver() {
        let socialIdData = SocialIdData(socialLoginType: .naver)
        tryUmpaLogin(with: socialIdData)
            .store(in: cancelBag)
    }

    func loginWithGoogle() {
        let socialIdData = SocialIdData(socialLoginType: .google)
        tryUmpaLogin(with: socialIdData)
            .store(in: cancelBag)
    }
}

extension LoginInteractorImpl {
    @MainActor
    private func _loginWithKakao() async -> (OAuthToken?, Error?) {
        if UserApi.isKakaoTalkLoginAvailable() {
            return await withCheckedContinuation { continuation in
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    continuation.resume(returning: (oauthToken, error))
                }
            }
        } else {
            return await withCheckedContinuation { continuation in
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    continuation.resume(returning: (oauthToken, error))
                }
            }
        }
    }

    private func tryUmpaLogin(with socialIdData: SocialIdData) -> AnyCancellable {
        useCase.checkAccountLinkedSocialId(with: socialIdData)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { user in
                if let user {
                    appState.userData.login.currentUser = user
                    switch user.userType {
                    case .student:
                        appState.routing.currentTab = .teacherFinder
                    case .teacher:
                        appState.routing.currentTab = .teacherHome
                    }
                } else {
                    appState.routing.loginNavigationPath.append(SocialLoginType.apple)
                }
            }
    }
}
