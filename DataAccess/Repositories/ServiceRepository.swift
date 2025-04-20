// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultServiceRepository {
    public init() {}
}

extension DefaultServiceRepository: ServiceRepository {
    public func postAccompanistService(_ accompanistService: Domain.AccompanistServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postCompositionService(_ compositionService: Domain.ScoreCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postMusicCreationService(_ musicCreationService: Domain.MusicCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postLessonService(_ lessonService: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func fetchAllLessonAndServiceList() -> AnyPublisher<[Domain.AnyService], any Error> {
        fatalError()
    }

    public func fetchMyLessonList(with: Domain.AccessToken) -> AnyPublisher<[Domain.LessonService], any Error> {
        fatalError()
    }

    public func fetchMyServiceList(with: Domain.AccessToken) -> AnyPublisher<[Domain.AnyService], any Error> {
        fatalError()
    }

    public func fetchMyLessonAndServiceList(with: Domain.AccessToken) -> AnyPublisher<[Domain.AnyService], any Error> {
        fatalError()
    }

    public func fetchLessonServiceList() -> AnyPublisher<[Domain.LessonService], any Error> {
        fatalError()
    }

    public func fetchAccompanistServiceList() -> AnyPublisher<[Domain.AccompanistService], any Error> {
        fatalError()
    }

    public func fetchScoreCreationServiceList() -> AnyPublisher<[Domain.ScoreCreationService], any Error> {
        fatalError()
    }

    public func fetchMusicCreationServiceList() -> AnyPublisher<[Domain.MusicCreationService], any Error> {
        fatalError()
    }

    public func fetchLessonDetail(by id: Domain.LessonService.Id) -> AnyPublisher<Domain.LessonService, any Error> {
        fatalError()
    }

    public func fetchAccompanistServiceDetail(by id: Domain.AnyService.Id) -> AnyPublisher<Domain.AccompanistService, any Error> {
        fatalError()
    }

    public func fetchScoreCreationServiceDetail(by id: Domain.AnyService.Id) -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        fatalError()
    }

    public func fetchMusicCreationServiceDetail(by id: Domain.AnyService.Id) -> AnyPublisher<Domain.MusicCreationService, any Error> {
        fatalError()
    }

    public func fetchServiceDetail(by id: Domain.AnyService.Id) -> AnyPublisher<Domain.AnyService, any Error> {
        fatalError()
    }

    public func fetchFavoriteServiceList() -> AnyPublisher<[Domain.AnyService], any Error> {
        fatalError()
    }

    public func updateLikeStatus(_ isLiked: Bool, for id: Domain.AnyService.Id) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubServiceRepository {
    public init() {}
}

extension StubServiceRepository: ServiceRepository {
    public func fetchMyLessonAndServiceList(with: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
        let allServices: [AnyService] = [
            LessonService.sample0.eraseToAnyService(),
            AccompanistService.sample0.eraseToAnyService(),
            ScoreCreationService.sample0.eraseToAnyService(),
            MusicCreationService.sample0.eraseToAnyService(),
        ]
        return Just(allServices)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func updateLikeStatus(_ isLiked: Bool, for id: String) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMyServiceList(with: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
        Just([
            AccompanistService.sample0.eraseToAnyService(),
            ScoreCreationService.sample0.eraseToAnyService(),
            MusicCreationService.sample0.eraseToAnyService(),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchFavoriteServiceList() -> AnyPublisher<[AnyService], any Error> {
        let allServices: [AnyService] = [
            LessonService.sample0.eraseToAnyService(),
            AccompanistService.sample0.eraseToAnyService(),
            ScoreCreationService.sample0.eraseToAnyService(),
            MusicCreationService.sample0.eraseToAnyService(),
        ]

        let favoriteServices = allServices.filter { service in
            Student.sample0.favoriteServices.contains(service.id)
        }

        return Just(favoriteServices)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchLessonServiceList() -> AnyPublisher<[Domain.LessonService], any Error> {
        Just([
            LessonService.sample0,
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchAccompanistServiceList() -> AnyPublisher<[Domain.AccompanistService], any Error> {
        Just([AccompanistService.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchScoreCreationServiceList() -> AnyPublisher<[Domain.ScoreCreationService], any Error> {
        Just([ScoreCreationService.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMusicCreationServiceList() -> AnyPublisher<[Domain.MusicCreationService], any Error> {
        Just([MusicCreationService.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchStudentData() -> AnyPublisher<Domain.Student, any Error> {
        Just(Student.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchTeacherData() -> AnyPublisher<Domain.Teacher, any Error> {
        Just(Teacher.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAllLessonAndServiceList() -> AnyPublisher<[AnyService], any Error> {
        Just<[AnyService]>([
            LessonService.sample0.eraseToAnyService(),
            AccompanistService.sample0.eraseToAnyService(),
            ScoreCreationService.sample0.eraseToAnyService(),
            MusicCreationService.sample0.eraseToAnyService(),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchLessonDetail(by id: Domain.LessonService.Id) -> AnyPublisher<Domain.LessonService, any Error> {
        Just(LessonService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAccompanistServiceDetail(by id: String) -> AnyPublisher<Domain.AccompanistService, any Error> {
        Just(AccompanistService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchScoreCreationServiceDetail(by id: String) -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        Just(ScoreCreationService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMusicCreationServiceDetail(by id: String) -> AnyPublisher<Domain.MusicCreationService, any Error> {
        Just(MusicCreationService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchServiceDetail(by id: String) -> AnyPublisher<AnyService, any Error> {
        fatalError()
    }

    public func postLessonService(_ lessonService: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postAccompanistService(_ accompanistService: Domain.AccompanistServiceCreateData) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postCompositionService(_ compositionService: Domain.ScoreCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postMusicCreationService(_ musicCreationService: Domain.MusicCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMyLessonList(with: AccessToken) -> AnyPublisher<[Domain.LessonService], any Error> {
        Just([
            LessonService.sample0,
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
#endif
