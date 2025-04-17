// Created for Umpa in 2025

import AuthenticationServices
import Combine
import Domain
import Factory
import Foundation
import Mockable
import SwiftUI
import Utility

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
                tryLogin(with: socialIdData)
                    .store(in: cancelBag)
            default:
                assertionFailure()
            }
        } catch: { _ in
            // TODO: Handle error
        }
    }

    func loginWithKakao() {
        let socialIdData = SocialIdData(socialLoginType: .kakao)
        tryLogin(with: socialIdData)
            .store(in: cancelBag)
    }

    func loginWithNaver() {
        let socialIdData = SocialIdData(socialLoginType: .naver)
        tryLogin(with: socialIdData)
            .store(in: cancelBag)
    }

    func loginWithGoogle() {
        let socialIdData = SocialIdData(socialLoginType: .google)
        tryLogin(with: socialIdData)
            .store(in: cancelBag)
    }

    private func tryLogin(with socialIdData: SocialIdData) -> AnyCancellable {
        useCase.checkAccountLinkedSocialId(with: socialIdData)
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
