// Created for Umpa in 2025

import Combine
import Domain

protocol TeacherSignUpInteractor {
    func completeSignUp(with model: TeacherSignUpModel)
}

struct DefaultTeacherSignUpInteractor {
    public init() {}
}

extension DefaultTeacherSignUpInteractor: TeacherSignUpInteractor {
    func completeSignUp(with model: TeacherSignUpModel) {
        fatalError("Not implemented")
    }
}
