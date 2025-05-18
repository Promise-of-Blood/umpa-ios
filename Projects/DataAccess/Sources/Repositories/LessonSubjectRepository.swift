// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultLessonSubjectRepository {
    private let network: Network

    public init(network: Network) {
        self.network = network
    }
}

extension DefaultLessonSubjectRepository: LessonSubjectRepository {
    public func fetchLessonSubjectList() -> AnyPublisher<[LessonSubject], any Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubLessonSubjectRepository: LessonSubjectRepository {
    public init() {}

    public func fetchLessonSubjectList() -> AnyPublisher<[LessonSubject], any Error> {
        Just([
            LessonSubject(name: "피아노"),
            LessonSubject(name: "보컬"),
            LessonSubject(name: "작곡"),
            LessonSubject(name: "드럼"),
            LessonSubject(name: "기타"),
            LessonSubject(name: "베이스"),
            LessonSubject(name: "관악"),
            LessonSubject(name: "전자음악"),
            LessonSubject(name: "전통화성학"),
            LessonSubject(name: "실용화성학"),
            LessonSubject(name: "시창청음"),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
#endif
