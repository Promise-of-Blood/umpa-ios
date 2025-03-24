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

    // TODO: 네트워크 요청 에러 시 처리 로직 추가 (Ex: Binding<Error?> 사용하여 Finish 화면의 error state 업데이트)
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
