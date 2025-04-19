// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import Mockable
import Core

protocol SignUpInteractor {
    func completeSignUp(with model: SignUpModel)
}

struct SignUpInteractorImpl {
    let appState: AppState
    let useCase: UseCase

    let cancelBag = CancelBag()

    init(appState: AppState, useCase: UseCase) {
        self.appState = appState
        self.useCase = useCase

        #if DEBUG
        if let mockUseCase = useCase as? MockUseCase {
            given(mockUseCase)
                .signUp().willReturn(
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

        useCase.signUp()
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
