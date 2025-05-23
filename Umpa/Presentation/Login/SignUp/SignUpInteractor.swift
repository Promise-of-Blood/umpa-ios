// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import Foundation

protocol SignUpInteractor {
    @MainActor func signUp(with model: SignUpModel) async
}

struct DefaultSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState

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

#if MOCK
struct MockSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState

    func signUp(with model: SignUpModel) async {
        appState.userData.currentUser = Student.sample0
        Container.shared.manager.reset(scope: .signUpSession)
    }
}
#endif
