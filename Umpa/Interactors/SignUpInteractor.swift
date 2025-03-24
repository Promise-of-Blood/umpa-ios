// Created for Umpa in 2025

import Factory
import Foundation
import Networking

struct SignUpInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.umpaApi) private var umpaApi

    @MainActor
    func signUp(with model: SignUpModel) async {
        // TODO: Implement

        // Convert to API model
        // model.toApiModel()

        // Request signUp
        // let result = await umpaApi.signUp(requestModel)

        appState.isLoggedIn = true

        Container.shared.manager.reset(scope: .signUpSession)
    }
}
