// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol UserRepository {
    func fetchStudentData() -> AnyPublisher<Student, Error>
    func fetchTeacherData() -> AnyPublisher<Teacher, Error>
}
