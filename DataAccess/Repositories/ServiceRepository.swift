// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultServiceRepository {
  public init() {}
}

extension DefaultServiceRepository: ServiceRepository {
  public func fetchFilteredLessonServiceList(with _: Domain.LessonServiceFilter) -> AnyPublisher<[Domain.LessonService], any Error> {
    fatalError()
  }

  public func postAccompanistService(_: Domain.AccompanistServiceCreateData) -> AnyPublisher<Void, any Error> {
    fatalError()
  }

  public func postCompositionService(_: Domain.ScoreCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
    fatalError()
  }

  public func postMusicCreationService(_: Domain.MusicCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
    fatalError()
  }

  public func postLessonService(_: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
    fatalError()
  }

  public func fetchAllLessonAndServiceList() -> AnyPublisher<[Domain.AnyService], any Error> {
    fatalError()
  }

  public func fetchMyLessonList(with _: Domain.AccessToken) -> AnyPublisher<[Domain.LessonService], any Error> {
    fatalError()
  }

  public func fetchMyServiceList(with _: Domain.AccessToken) -> AnyPublisher<[Domain.AnyService], any Error> {
    fatalError()
  }

  public func fetchMyLessonAndServiceList(with _: Domain.AccessToken) -> AnyPublisher<[Domain.AnyService], any Error> {
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

  public func fetchLessonDetail(by _: Domain.LessonService.Id) -> AnyPublisher<Domain.LessonService, any Error> {
    fatalError()
  }

  public func fetchAccompanistServiceDetail(by _: Domain.AnyService.Id) -> AnyPublisher<Domain.AccompanistService, any Error> {
    fatalError()
  }

  public func fetchScoreCreationServiceDetail(by _: Domain.AnyService.Id) -> AnyPublisher<Domain.ScoreCreationService, any Error> {
    fatalError()
  }

  public func fetchMusicCreationServiceDetail(by _: Domain.AnyService.Id) -> AnyPublisher<Domain.MusicCreationService, any Error> {
    fatalError()
  }

  public func fetchServiceDetail(by _: Domain.AnyService.Id) -> AnyPublisher<Domain.AnyService, any Error> {
    fatalError()
  }

  public func fetchFavoriteServiceList() -> AnyPublisher<[Domain.AnyService], any Error> {
    fatalError()
  }

  public func updateLikeStatus(_: Bool, for _: Domain.AnyService.Id) -> AnyPublisher<Void, any Error> {
    fatalError()
  }
}

#if DEBUG
  public struct StubServiceRepository {
    public init() {}
  }

  extension StubServiceRepository: ServiceRepository {
    public func fetchFilteredLessonServiceList(with _: Domain.LessonServiceFilter) -> AnyPublisher<[Domain.LessonService], any Error> {
      Just([
        LessonService.sample0,
      ])
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
    }

    public func fetchMyLessonAndServiceList(with _: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
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

    public func updateLikeStatus(_: Bool, for _: String) -> AnyPublisher<Void, any Error> {
      Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchMyServiceList(with _: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
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
        LessonService.sample1,
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

    public func fetchLessonDetail(by _: Domain.LessonService.Id) -> AnyPublisher<Domain.LessonService, any Error> {
      Just(LessonService.sample0)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchAccompanistServiceDetail(by _: String) -> AnyPublisher<Domain.AccompanistService, any Error> {
      Just(AccompanistService.sample0)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchScoreCreationServiceDetail(by _: String) -> AnyPublisher<Domain.ScoreCreationService, any Error> {
      Just(ScoreCreationService.sample0)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchMusicCreationServiceDetail(by _: String) -> AnyPublisher<Domain.MusicCreationService, any Error> {
      Just(MusicCreationService.sample0)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchServiceDetail(by _: String) -> AnyPublisher<AnyService, any Error> {
      fatalError()
    }

    public func postLessonService(_: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
      Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func postAccompanistService(_: Domain.AccompanistServiceCreateData) -> AnyPublisher<Void, any Error> {
      Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func postCompositionService(_: Domain.ScoreCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
      Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func postMusicCreationService(_: Domain.MusicCreationServiceCreateData) -> AnyPublisher<Void, any Error> {
      Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchMyLessonList(with _: AccessToken) -> AnyPublisher<[Domain.LessonService], any Error> {
      Just([
        LessonService.sample0,
      ])
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
    }
  }
#endif
