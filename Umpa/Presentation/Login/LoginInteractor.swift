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

    enum AppleLoginFailedReason {
        case unexpectedAuthorizationType
    }

    case appleLoginFailed(AppleLoginFailedReason)
}

@MainActor
protocol LoginInteractor {
    func loginWithApple(
        with authorizationController: AuthorizationController,
        isTappedAnyLoginButton: Binding<Bool>,
        socialLoginType: Binding<SocialLoginType?>
    )
    func loginWithKakao(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>)
    func loginWithNaver(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>)
    func loginWithGoogle(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>)
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
        isTappedAnyLoginButton: Binding<Bool>,
        socialLoginType: Binding<SocialLoginType?>
    ) {
        isTappedAnyLoginButton.wrappedValue = true

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        authorizationController.performRequest(request)
            .handleEvents(receiveOutput: { result in // FIXME: 삭제 예정
                if case .appleID(let credential) = result {
                    print(credential.user)
                    print(String(describing: credential.fullName))
                    print(String(describing: credential.email))
                }
            })
            .tryMap { result in
                switch result {
                case .appleID(let appleIDCredential):
                    return SocialIdData(socialLoginType: .apple)
                default:
                    assertionFailure()
                    throw LoginInteractorError.appleLoginFailed(.unexpectedAuthorizationType)
                }
            }
            .flatMap { checkAccountLinkedSocialId(with: $0) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                isTappedAnyLoginButton.wrappedValue = false
                if let error = completion.error {
                    // TODO: Handle error
                    UmpaLogger.log(error.localizedDescription, level: .error)
                }
            } receiveValue: { [appState] user in
                if let user {
                    loginByUser(user)
                } else {
                    socialLoginType.wrappedValue = .apple
                    appState.routing.loginNavigationPath.append(LoginView.NavigationDestination.phoneNumberInput)
                }
            }
            .store(in: cancelBag)
    }

    func loginWithKakao(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>) {
        isTappedAnyLoginButton.wrappedValue = true

        loginWithKakaoAppropriately()
            .handleEvents(receiveOutput: { oauthToken in // FIXME: 삭제 예정
                print(String(describing: oauthToken.idToken))
            })
            .map { _ in
                SocialIdData(socialLoginType: .kakao)
            }
            .flatMap { checkAccountLinkedSocialId(with: $0) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                isTappedAnyLoginButton.wrappedValue = false
                if let error = completion.error {
                    // TODO: Handle error
                    UmpaLogger.log(error.localizedDescription, level: .error)
                }
            } receiveValue: { [appState] user in
                if let user {
                    loginByUser(user)
                } else {
                    socialLoginType.wrappedValue = .kakao
                    appState.routing.loginNavigationPath.append(LoginView.NavigationDestination.phoneNumberInput)
                }
            }
            .store(in: cancelBag)
    }

    func loginWithNaver(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>) {
        isTappedAnyLoginButton.wrappedValue = true

        NidOAuth.shared.requestLogin()
            .map(\.accessToken.tokenString)
            .flatMap { NidOAuth.shared.getUserProfile(accessToken: $0) }
            .handleEvents(receiveOutput: { profileResult in // FIXME: 삭제 예정
                print(String(describing: profileResult["id"]))
            })
            .map { _ in
                SocialIdData(socialLoginType: .naver)
            }
            .flatMap { checkAccountLinkedSocialId(with: $0) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                isTappedAnyLoginButton.wrappedValue = false
                if let error = completion.error {
                    // TODO: Handle error
                    UmpaLogger.log(error.localizedDescription, level: .error)
                }
            } receiveValue: { [appState] user in
                if let user {
                    loginByUser(user)
                } else {
                    socialLoginType.wrappedValue = .naver
                    appState.routing.loginNavigationPath.append(LoginView.NavigationDestination.phoneNumberInput)
                }
            }
            .store(in: cancelBag)
    }

    func loginWithGoogle(isTappedAnyLoginButton: Binding<Bool>, socialLoginType: Binding<SocialLoginType?>) {
        guard let presentingVC = UIApplication.shared.keyRootViewController else {
            UmpaLogger.log("No presenting view controller")
            return
        }

        isTappedAnyLoginButton.wrappedValue = true

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC)
            .handleEvents(receiveOutput: { result in // FIXME: 삭제 예정
                print(String(describing: result.serverAuthCode))
                print(String(describing: result.user.idToken?.tokenString))
                print(String(describing: result.user.profile?.name))
            })
            .map { _ in
                SocialIdData(socialLoginType: .google)
            }
            .flatMap { checkAccountLinkedSocialId(with: $0) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                isTappedAnyLoginButton.wrappedValue = false
                if let error = completion.error {
                    // TODO: Handle error
                    UmpaLogger.log(error.localizedDescription, level: .error)
                }
            } receiveValue: { [appState] user in
                if let user {
                    loginByUser(user)
                } else {
                    socialLoginType.wrappedValue = .google
                    appState.routing.loginNavigationPath.append(LoginView.NavigationDestination.phoneNumberInput)
                }
            }
            .store(in: cancelBag)
    }
}

// MARK: - Private Methods

extension DefaultLoginInteractor {
    private func loginWithKakaoAppropriately() -> AnyPublisher<OAuthToken, Error> {
        Future { promise in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error {
                        promise(.failure(error))
                        return
                    }
                    guard let oauthToken else {
                        promise(.failure(LoginInteractorError.kakaoLoginFailed(.missingOauthToken)))
                        return
                    }
                    promise(.success(oauthToken))
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error {
                        promise(.failure(error))
                        return
                    }
                    guard let oauthToken else {
                        promise(.failure(LoginInteractorError.kakaoLoginFailed(.missingOauthToken)))
                        return
                    }
                    promise(.success(oauthToken))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func loginByUser(_ user: AnyUser) {
        appState.userData.loginInfo.currentUser = user
        switch user.userType {
        case .student:
            appState.routing.currentTab = .teacherFinder
        case .teacher:
            appState.routing.currentTab = .teacherHome
        }
    }
}

// MARK: - NidOAuth + Combine

extension NidOAuth {
    func requestLogin() -> AnyPublisher<LoginResult, Error> {
        Future { [self] promise in
            requestLogin { result in
                switch result {
                case .success(let loginResult):
                    promise(.success(loginResult))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getUserProfile(accessToken: String) -> AnyPublisher<[String: String], Error> {
        Future { [self] promise in
            getUserProfile(accessToken: accessToken) { result in
                switch result {
                case .success(let profileResult):
                    promise(.success(profileResult))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - GIDSignIn + Combine

extension GIDSignIn {
    func signIn(withPresenting presentingViewController: UIViewController) -> AnyPublisher<GIDSignInResult, Error> {
        Future { [self] promise in
            Task {
                do {
                    let result = try await signIn(withPresenting: presentingViewController)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - AuthorizationController + Combine

extension AuthorizationController {
    func performRequest(_ request: ASAuthorizationRequest) -> AnyPublisher<ASAuthorizationResult, Error> {
        Future { promise in
            Task {
                do {
                    let result = try await performRequest(request)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
