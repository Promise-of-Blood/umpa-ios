// Created for Umpa in 2025

import Factory
import Foundation
import Networking

struct SignUpInteractor {
    @Injected(\.appState) private var appState: AppState
//    @In

    @MainActor
    func signUp() {
        // TODO: Implement

        // let userInfo =
        // let result = await interactor.signUp(with: userInfo)
        // if result ... {

        appState.isLoggedIn = true
    }
}
