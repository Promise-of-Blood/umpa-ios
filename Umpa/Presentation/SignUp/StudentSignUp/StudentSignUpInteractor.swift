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
        isDuplicatedUsername: ValueLoadableBinding<Bool?>,
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
                        .delay(for: 1, scheduler: DispatchQueue.main)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
        if let mockCheckAvailableUsername = checkAvailableUsername as? MockCheckAvailableUsernameUseCase {
            given(mockCheckAvailableUsername)
                .callAsFunction(.any)
                .willProduce { username in
                    if username == "A" {
                        return Just(false)
                            .delay(for: 1, scheduler: DispatchQueue.main)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } else {
                        return Just(true)
                            .delay(for: 1, scheduler: DispatchQueue.main)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                }
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
            } receiveValue: { [appState] student in
                appState.userData.loginInfo.currentUser = student.eraseToAnyUser()
            }
            .store(in: cancelBag)
    }

    func performDuplicateCheck(
        username: String,
        isShowingUsernameAlert: Binding<Bool>,
        isDuplicatedUsername: ValueLoadableBinding<Bool?>,
    ) {
        let cancelBag = CancelBag()

        isDuplicatedUsername.wrappedValue.setIsLoading(cancelBag: cancelBag)

        checkAvailableUsername(username)
            .sink { completion in
                if completion.isError {
                    // Handle error
                }
            } receiveValue: { isAvailable in
                isShowingUsernameAlert.wrappedValue = isAvailable
                isDuplicatedUsername.wrappedValue.value = !isAvailable
            }
            .store(in: cancelBag)
    }
}
