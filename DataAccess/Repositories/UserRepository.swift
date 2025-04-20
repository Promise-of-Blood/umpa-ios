// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultUserRepository {
    public init() {}
}

extension DefaultUserRepository: UserRepository {
    public func fetchStudentData() -> AnyPublisher<Domain.Student, any Error> {
        fatalError()
    }

    public func fetchTeacherData() -> AnyPublisher<Domain.Teacher, any Error> {
        fatalError()
    }
}
