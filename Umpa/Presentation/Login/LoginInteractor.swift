// Created for Umpa in 2025

import AuthenticationServices
import Combine
import Core
import Domain
import Factory
import Foundation
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKUser
import Mockable
import NidThirdPartyLogin
import SwiftUI

enum LoginInteractorError: LocalizedError {
    enum KakaoLoginFailedReason {
        case missingOauthToken
    }

    case kakaoLoginFailed(KakaoLoginFailedReason)
}

@MainActor
protocol LoginInteractor {
    func loginWithApple(
        with authorizationController: AuthorizationController,
        socialLoginType: Binding<SocialLoginType?>
    )
    func loginWithKakao(socialLoginType: Binding<SocialLoginType?>)
    func loginWithNaver(socialLoginType: Binding<SocialLoginType?>)
    func loginWithGoogle(socialLoginType: Binding<SocialLoginType?>)
}

struct DefaultLoginInteractor {
    private let appState: AppState

    private let checkAccountLinkedSocialId: CheckAccountLinkedSocialIdUseCase

    private let cancelBag = CancelBag()

    init(
        appState: AppState,
        checkAccountLinkedSocialIdUseCase: CheckAccountLinkedSocialIdUseCase
    ) {
        self.appState = appState
        self.checkAccountLinkedSocialId = checkAccountLinkedSocialIdUseCase

        #if DEBUG
        setupMockBehavior()
        #endif
    }

    #if DEBUG
    private func setupMockBehavior() {
        if let mockCheckAccountLinkedSocialIdUseCase = checkAccountLinkedSocialId as? MockCheckAccountLinkedSocialIdUseCase {
            given(mockCheckAccountLinkedSocialIdUseCase)
                .callAsFunction(with: .matching { data in
                    data.socialLoginType == .kakao
                })
                .willReturn(
                    Just(Student.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .callAsFunction(with: .matching { data in
                    data.socialLoginType == .naver
                })
                .willReturn(
                    Just(nil)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .callAsFunction(with: .matching { data in
                    data.socialLoginType == .google
                })
                .willReturn(
                    Just(Teacher.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
    }
    #endif
}

extension DefaultLoginInteractor: LoginInteractor {
    func loginWithApple(
        with authorizationController: AuthorizationController,
        socialLoginType: Binding<SocialLoginType?>
    ) {
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
                attemptUmpaLogin(with: socialIdData, socialLoginType: socialLoginType)
                    .store(in: cancelBag)
            default:
                assertionFailure()
            }
        } catch: { _ in
            // TODO: Handle error
        }
    }

    func loginWithKakao(socialLoginType: Binding<SocialLoginType?>) {
        Task {
            let oauthToken = try await _loginWithKakao()
            print(oauthToken.idToken)

            let socialIdData = SocialIdData(socialLoginType: .kakao)
            attemptUmpaLogin(with: socialIdData, socialLoginType: socialLoginType)
                .store(in: cancelBag)
        } catch: { error in
            print(error)
        }
    }

    func loginWithNaver(socialLoginType: Binding<SocialLoginType?>) {
        Task {
            let loginResult = try await NidOAuth.shared.requestLogin()
            let accessToken = loginResult.accessToken.tokenString
            let profileResult = try await NidOAuth.shared.getUserProfile(accessToken: accessToken)
            let id = profileResult["id"]
            print("Id: ", id)

            let socialIdData = SocialIdData(socialLoginType: .naver)
            attemptUmpaLogin(with: socialIdData, socialLoginType: socialLoginType)
                .store(in: cancelBag)
        } catch: { error in
            print("Error: ", error.localizedDescription)
        }
    }

    func loginWithGoogle(socialLoginType: Binding<SocialLoginType?>) {
        guard let presentingVC = UIApplication.shared.keyRootViewController else {
            UmpaLogger.log("No presenting view controller")
            return
        }

        Task {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC)
            UmpaLogger.log(result.serverAuthCode ?? "")
            let user = result.user
            UmpaLogger.log(user.idToken?.tokenString ?? "")
            UmpaLogger.log(user.profile?.name ?? "")

            let socialIdData = SocialIdData(socialLoginType: .google)
            attemptUmpaLogin(with: socialIdData, socialLoginType: socialLoginType)
                .store(in: cancelBag)
        } catch: { error in
            UmpaLogger.log(error.localizedDescription, level: .error)
        }
    }
}

// MARK: - Private Methods

extension DefaultLoginInteractor {
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

    /// 소셜 로그인 후 아이디 정보로 Umpa 로그인을 시도합니다.
    @MainActor
    private func attemptUmpaLogin(
        with socialIdData: SocialIdData,
        socialLoginType: Binding<SocialLoginType?>
    ) -> AnyCancellable {
        checkAccountLinkedSocialId(with: socialIdData)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { [appState] user in
                if let user {
                    loginByUser(user)
                } else {
                    socialLoginType.wrappedValue = socialIdData.socialLoginType
                    appState.routing.loginNavigationPath.append(SignUpRoute.phoneNumberVerification)
                }
            }
    }

    private func loginByUser(_ user: AnyUser) {
        appState.userData.login.currentUser = user
        switch user.userType {
        case .student:
            appState.routing.currentTab = .teacherFinder
        case .teacher:
            appState.routing.currentTab = .teacherHome
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
