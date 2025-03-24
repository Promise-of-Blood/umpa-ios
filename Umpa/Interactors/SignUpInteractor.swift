// Created for Umpa in 2025

import Factory
import Foundation
import Networking

protocol SignUpInteractor {
    @MainActor func signUp(with model: SignUpModel) async
}

struct DefaultSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.umpaApi) private var umpaApi

    func signUp(with model: SignUpModel) async {
        // TODO: Implement

        // Convert to API model
        // model.toApiModel()

        // Request signUp
        // let result = await umpaApi.signUp(requestModel)

//        appState.isLoggedIn = true

//        Container.shared.manager.reset(scope: .signUpSession)

        fatalError()
    }
}

#if DEBUG
struct MockSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState

    func signUp(with model: SignUpModel) async {
        appState.isLoggedIn = true
        Container.shared.manager.reset(scope: .signUpSession)
    }
}
#endif
