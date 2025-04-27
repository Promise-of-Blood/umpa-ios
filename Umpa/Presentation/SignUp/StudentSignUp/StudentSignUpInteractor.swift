// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation
import Mockable
import SwiftUICore

@MainActor
protocol StudentSignUpInteractor {
    func completeSignUp(with model: StudentSignUpModel)
    func performDuplicateCheck(
        username: String,
        isShowingUsernameAlert: Binding<Bool>,
        isDuplicatedUsername: Binding<Bool?>,
    )
}

struct DefaultStudentSignUpInteractor {
    private let appState: AppState

    private let signUp: StudentSignUpUseCase
    private let checkAvailableUsername: CheckAvailableUsernameUseCase

    private let cancelBag = CancelBag()

    init(appState: AppState, signUp: StudentSignUpUseCase, checkAvailableUsername: CheckAvailableUsernameUseCase) {
        self.appState = appState
        self.signUp = signUp
        self.checkAvailableUsername = checkAvailableUsername

        #if DEBUG
        setupMockBehavior()
        #endif
    }

    #if DEBUG
    private func setupMockBehavior() {
        if let mockSignUp = signUp as? MockStudentSignUpUseCase {
            given(mockSignUp)
                .callAsFunction(with: .any)
                .willReturn(
                    Just(Student.sample0)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
        if let mockCheckAvailableUsername = checkAvailableUsername as? MockCheckAvailableUsernameUseCase {
            given(mockCheckAvailableUsername)
                .callAsFunction(.any)
                .willReturn(
                    Just(true)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
    }
    #endif
}

extension DefaultStudentSignUpInteractor: StudentSignUpInteractor {
    func completeSignUp(with model: StudentSignUpModel) {
        guard let studentCreateData = model.toDomain() else {
            // TODO: Handle exception - 뭔가 필요한 정보가 입력되지 않은 경우
            return
        }
        signUp(with: studentCreateData)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { student in
                appState.userData.login.currentUser = student.eraseToAnyUser()
            }
            .store(in: cancelBag)
    }

    func performDuplicateCheck(
        username: String,
        isShowingUsernameAlert: Binding<Bool>,
        isDuplicatedUsername: Binding<Bool?>,
    ) {
        checkAvailableUsername(username)
            .sink { completion in
                if completion.isError {
                    // Handle error
                }
            } receiveValue: { isAvailable in
                isShowingUsernameAlert.wrappedValue = isAvailable
                isDuplicatedUsername.wrappedValue = !isAvailable
            }
            .store(in: cancelBag)
    }
}
