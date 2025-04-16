// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import Utility

protocol SignUpInteractor {
    func completeSignUp(with model: SignUpModel)
}

struct SignUpInteractorImpl {
    @Injected(\.appState) private var appState
    @Injected(\.useCase) private var useCase

    private let cancelBag = CancelBag()
}

extension SignUpInteractorImpl: SignUpInteractor {
    // TODO: 네트워크 요청 에러 시 처리 로직 추가 (Ex: Binding<Error?> 사용하여 Finish 화면의 error state 업데이트)
    func completeSignUp(with model: SignUpModel) {
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

#if DEBUG
struct MockSignUpInteractor: SignUpInteractor {
    @Injected(\.appState) private var appState

    func completeSignUp(with model: SignUpModel) {
        appState.userData.login.currentUser = Student.sample0
        Container.shared.manager.reset(scope: .signUpSession)
    }
}
#endif
