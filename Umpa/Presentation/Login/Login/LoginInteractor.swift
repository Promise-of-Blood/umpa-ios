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
    let serverRepository: ServerRepository
    let useCase: UseCase

    let cancelBag = CancelBag()

    init(
        appState: AppState,
        serverRepository: ServerRepository,
        useCase: UseCase
    ) {
        self.appState = appState
        self.serverRepository = serverRepository
        self.useCase = useCase

        #if DEBUG
        if let mockUseCase = useCase as? MockUseCase {
            given(mockUseCase)
                .loginWithApple().willReturn(
                    Just(Student.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .loginWithKakao().willReturn(
                    Just(Student.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .loginWithGoogle().willReturn(
                    Just(Teacher.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
                .loginWithKakao().willReturn(
                    Just(Student.sample0.eraseToAnyUser())
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
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email

                useCase.loginWithApple()
                    .sink { completion in
                        if let error = completion.error {
                            // TODO: Handle error
                            // 로그인 실패
                        }
                    } receiveValue: { user in
                        appState.userData.login.currentUser = user
                        switch user.userType {
                        case .student:
                            appState.routing.currentTab = .teacherFinder
                        case .teacher:
                            appState.routing.currentTab = .teacherHome
                        }
                    }
                    .store(in: cancelBag)
            default:
                break
            }
        }
    }

    func loginWithKakao() {
        useCase.loginWithKakao()
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                    // 로그인 실패
                }
            } receiveValue: { user in
                appState.userData.login.currentUser = user
                switch user.userType {
                case .student:
                    appState.routing.currentTab = .teacherFinder
                case .teacher:
                    appState.routing.currentTab = .teacherHome
                }
            }
            .store(in: cancelBag)
    }

    func loginWithNaver() {
        useCase.loginWithNaver()
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                    // 로그인 실패
                }
            } receiveValue: { user in
                appState.userData.login.currentUser = user
                switch user.userType {
                case .student:
                    appState.routing.currentTab = .teacherFinder
                case .teacher:
                    appState.routing.currentTab = .teacherHome
                }
            }
            .store(in: cancelBag)
    }

    func loginWithGoogle() {
        useCase.loginWithGoogle()
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                    // 로그인 실패
                }
            } receiveValue: { user in
                appState.userData.login.currentUser = user
                switch user.userType {
                case .student:
                    appState.routing.currentTab = .teacherFinder
                case .teacher:
                    appState.routing.currentTab = .teacherHome
                }
            }
            .store(in: cancelBag)
    }
}
