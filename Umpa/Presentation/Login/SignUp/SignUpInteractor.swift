// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import Mockable

@MainActor
protocol SignUpInteractor {
    func completeSignUp(with model: SignUpModel)
}

struct SignUpInteractorImpl {
    private let appState: AppState

    private let signUp: SignUpUseCase

    let cancelBag = CancelBag()

    init(appState: AppState, signUpUseCase: SignUpUseCase) {
        self.appState = appState
        self.signUp = signUpUseCase

        #if DEBUG
        if let mockSignUpUseCase = signUpUseCase as? MockSignUpUseCase {
            given(mockSignUpUseCase)
                .callAsFunction()
                .willReturn(
                    Just(Student.sample0.eraseToAnyUser())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
        #endif
    }
}

extension SignUpInteractorImpl: SignUpInteractor {
    // TODO: 네트워크 요청 에러 시 처리 로직 추가 (Ex: Binding<Error?> 사용하여 Finish 화면의 error state 업데이트)
    func completeSignUp(with model: SignUpModel) {
        // TODO: Implement

        // Convert to API model
        // model.toApiModel()

        signUp()
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { user in
                appState.userData.login.currentUser = user
                Container.shared.manager.reset(scope: .signUpSession)
            }
            .store(in: cancelBag)
    }
}
