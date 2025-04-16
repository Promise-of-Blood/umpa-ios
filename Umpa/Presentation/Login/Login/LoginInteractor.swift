// Created for Umpa in 2025

import AuthenticationServices
import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol LoginInteractor {
    func loginWithApple(with authorizationController: AuthorizationController)
    func loginWithKakao()
    func loginWithNaver()
    func loginWithGoogle()
}

struct LoginInteractorImpl {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.useCase) private var useCase
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

//                useCase.loginWithApple()
                #if MOCK
                appState.userData.login.currentUser = Student.sample0
                appState.routing.currentTab = .teacherFinder
                #endif
            default:
                break
            }
        }
    }

    func loginWithKakao() {
//        useCase.loginWithKakao()
        #if MOCK
        appState.userData.login.currentUser = Student.sample0
        appState.routing.currentTab = .teacherFinder
        #endif
    }

    func loginWithNaver() {
//        useCase.loginWithNaver()
        #if MOCK
        appState.userData.login.currentUser = Student.sample0
        appState.routing.currentTab = .teacherFinder
        #endif
    }

    func loginWithGoogle() {
//        useCase.loginWithGoogle()
        #if MOCK
        appState.userData.login.currentUser = Teacher.sample0
        appState.routing.currentTab = .teacherHome
        #endif
    }
}
