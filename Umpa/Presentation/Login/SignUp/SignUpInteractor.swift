// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import Utility

protocol SignUpInteractor {
    @MainActor func signUp(with model: SignUpModel) async
}

struct SignUpInteractorImpl {
    @Injected(\.appState) private var appState
    @Injected(\.useCase) private var useCase

    private let cancelBag = CancelBag()
}

extension SignUpInteractorImpl: SignUpInteractor {
    // TODO: 네트워크 요청 에러 시 처리 로직 추가 (Ex: Binding<Error?> 사용하여 Finish 화면의 error state 업데이트)
    func signUp(with model: SignUpModel) async {
        // TODO: Implement

        // Convert to API model
        // model.toApiModel()

        useCase.signUp()
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { user in
                appState.userData.login.currentUser = user
            }
            .store(in: cancelBag)

        Container.shared.manager.reset(scope: .signUpSession)
    }
}

#if MOCK
struct MockSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState

    func signUp(with model: SignUpModel) async {
        appState.userData.login.currentUser = Student.sample0
        Container.shared.manager.reset(scope: .signUpSession)
    }
}
#endif
