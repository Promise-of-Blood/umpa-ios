// Created for Umpa in 2025

import Combine
import Core
import Domain
import Mockable

@MainActor
protocol TeacherSignUpInteractor {
    func signUp(with model: TeacherSignUpModel)
}

struct DefaultTeacherSignUpInteractor {
    private let appState: AppState

    private let signUp: TeacherSignUpUseCase

    private let cancelBag = CancelBag()

    init(appState: AppState, signUpUseCase: TeacherSignUpUseCase) {
        self.appState = appState
        self.signUp = signUpUseCase

        #if DEBUG
        setupMockBehavior()
        #endif
    }

    #if DEBUG
    private func setupMockBehavior() {
        if let mockSignUp = signUp as? MockTeacherSignUpUseCase {
            given(mockSignUp)
                .callAsFunction(with: .any)
                .willReturn(
                    Just(Teacher.sample0)
                        .delay(for: 1, scheduler: DispatchQueue.main)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
    }
    #endif
}

extension DefaultTeacherSignUpInteractor: TeacherSignUpInteractor {
    func signUp(with model: TeacherSignUpModel) {
        #if DEBUG
        UmpaLogger(category: .signUp).log("회원가입을 진행합니다 : \(model.debugDescription)", level: .debug)
        #endif

        guard let teacherCreateData = model.toDomain() else {
            // TODO: Handle exception - 뭔가 필요한 정보가 입력되지 않은 경우
            return
        }

        signUp(with: teacherCreateData)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { [appState] teacher in
                appState.userData.loginInfo.currentUser = teacher.eraseToAnyUser()
            }
            .store(in: cancelBag)
    }
}
