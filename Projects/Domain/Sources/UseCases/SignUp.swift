// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol StudentSignUpUseCase {
    func callAsFunction(with data: StudentCreateData) -> AnyPublisher<Student, Error>
}

public struct DefaultStudentSignUpUseCase {
    private let jwtRepository: JwtRepository

    public init(jwtRepository: JwtRepository) {
        self.jwtRepository = jwtRepository
    }
}

extension DefaultStudentSignUpUseCase: StudentSignUpUseCase {
    public func callAsFunction(with data: StudentCreateData) -> AnyPublisher<Student, Error> {
        fatalError("Not implemented")
    }
}

@Mockable
public protocol TeacherSignUpUseCase {
    func callAsFunction(with data: TeacherCreateData) -> AnyPublisher<Teacher, Error>
}

public struct DefaultTeacherSignUpUseCase {
    private let jwtRepository: JwtRepository

    public init(jwtRepository: JwtRepository) {
        self.jwtRepository = jwtRepository
    }
}

extension DefaultTeacherSignUpUseCase: TeacherSignUpUseCase {
    public func callAsFunction(with data: TeacherCreateData) -> AnyPublisher<Teacher, Error> {
        fatalError("Not implemented")
    }
}
