// Created for Umpa in 2025

import Foundation

protocol MyProfileInteractor {
    func logout()
}

struct MyProfileInteractorImpl {
    let appState: AppState
}

extension MyProfileInteractorImpl: MyProfileInteractor {
    func logout() {
        appState.reset()
    }
}
