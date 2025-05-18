// Created for Umpa in 2025

import Combine
import Foundation

public protocol LessonSubjectRepository {
    func fetchLessonSubjectList() -> AnyPublisher<[LessonSubject], Error>
}
