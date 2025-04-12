// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultRepository {
    public init() {}
}

extension DefaultRepository: Repository {
    public func fetchAcceptanceReviewCommentList(by id: Domain.AcceptanceReview.ID) -> AnyPublisher<[Domain.AcceptanceReview.Comment], any Error> {
        fatalError()
    }

    public func fetchPostList(with filter: Domain.Post.Filter) -> AnyPublisher<[Domain.Post], any Error> {
        fatalError()
    }

    public func fetchHotPostList() -> AnyPublisher<[Domain.Post], any Error> {
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

    public func fetchFavoriteServiceList() -> AnyPublisher<[any Domain.Service], any Error> {
        fatalError()
    }

    public func fetchMajorList() -> AnyPublisher<[Domain.Major], any Error> {
        fatalError()
    }

    public func fetchAcceptanceReviewList(by id: String) -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        fatalError()
    }

    public func fetchAllAcceptanceReviewList() -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        fatalError()
    }

    public func fetchHotAcceptanceReviewList() -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        fatalError()
    }

    public func fetchReview() -> AnyPublisher<Domain.Review, any Error> {
        fatalError("fetchReview() has not been implemented")
    }

    public func fetchReviewList() -> AnyPublisher<[Domain.Review], any Error> {
        fatalError("fetchReviewList() has not been implemented")
    }

    public func fetchAcceptanceReview() -> AnyPublisher<Domain.AcceptanceReview, any Error> {
        fatalError("fetchAcceptanceReview() has not been implemented")
    }

    public func fetchAcceptanceReviewList() -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        fatalError("fetchAcceptanceReviewList() has not been implemented")
    }

    public func fetchPost() -> AnyPublisher<Domain.Post, any Error> {
        fatalError("fetchPost() has not been implemented")
    }

    public func fetchPostList() -> AnyPublisher<[Domain.Post], any Error> {
        fatalError("fetchPostList() has not been implemented")
    }

    public func fetchMentoringPost() -> AnyPublisher<Domain.MentoringPost, any Error> {
        fatalError("fetchMentoringPost() has not been implemented")
    }

    public func fetchMentoringPostList() -> AnyPublisher<[Domain.MentoringPost], any Error> {
        fatalError("fetchMentoringPostList() has not been implemented")
    }

    public func fetchStudentData() -> AnyPublisher<Domain.Student, any Error> {
        fatalError("fetchStudentData() has not been implemented")
    }

    public func fetchTeacherData() -> AnyPublisher<Domain.Teacher, any Error> {
        fatalError("fetchTeacherData() has not been implemented")
    }

    public func fetchAllServiceList() -> AnyPublisher<[any Domain.Service], any Error> {
        fatalError("fetchAllServiceList() has not been implemented")
    }

    public func fetchLessonServiceDetail() -> AnyPublisher<Domain.LessonService, any Error> {
        fatalError("fetchLessonServiceDetail() has not been implemented")
    }

    public func fetchAccompanistServiceDetail() -> AnyPublisher<Domain.AccompanistService, any Error> {
        fatalError("fetchAccompanistServiceDetail() has not been implemented")
    }

    public func fetchScoreCreationServiceDetail() -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        fatalError("fetchCompositionServiceDetail() has not been implemented")
    }

    public func fetchMusicCreationServiceDetail() -> AnyPublisher<Domain.MusicCreationService, any Error> {
        fatalError("fetchMusicCreationServiceDetail() has not been implemented")
    }

    public func fetchServiceDetail() -> AnyPublisher<any Domain.Service, any Error> {
        fatalError("fetchServiceDetail() has not been implemented")
    }

    public func postLessonService(_ lessonService: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError("postLessonService() has not been implemented")
    }

    public func postAccompanistService(_ accompanistService: Domain.AccompanistService) -> AnyPublisher<Void, any Error> {
        fatalError("postAccompanistService() has not been implemented")
    }

    public func postCompositionService(_ compositionService: Domain.ScoreCreationService) -> AnyPublisher<Void, any Error> {
        fatalError("postCompositionService() has not been implemented")
    }

    public func postMusicCreationService(_ musicCreationService: Domain.MusicCreationService) -> AnyPublisher<Void, any Error> {
        fatalError("postMusicCreationService() has not been implemented")
    }

    public func fetchChattingRoomList() -> AnyPublisher<[Domain.ChattingRoom], any Error> {
        fatalError()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        fatalError("postChatMessage() has not been implemented")
    }
}

#if DEBUG
public struct StubRepository {
    public init() {}
}

extension StubRepository: Repository {
    public func fetchFavoriteServiceList() -> AnyPublisher<[any Domain.Service], any Error> {
        let allServices: [any Service] = [
            LessonService.sample0,
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
        ]

        let favoriteServices = allServices.filter { service in
            guard let serviceId = service.id else { return false }
            return Student.sample0.favoriteServices.contains(serviceId)
        }

        return Just(favoriteServices)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchLessonServiceList() -> AnyPublisher<[Domain.LessonService], any Error> {
        Just([LessonService.sample0])
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

    public func fetchHotPostList() -> AnyPublisher<[Domain.Post], any Error> {
        Just([Post.sample0, .sample1])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAcceptanceReviewCommentList(by id: Domain.AcceptanceReview.ID) -> AnyPublisher<[Domain.AcceptanceReview.Comment], any Error> {
        Just([AcceptanceReview.Comment.sample0, .sample1])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMajorList() -> AnyPublisher<[Domain.Major], any Error> {
        Just([
            Major.piano,
            Major.composition,
            Major.drum,
            Major.bass,
            Major.guitar,
            Major.vocal,
            Major.electronicMusic,
            Major.windInstrument,

        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchAcceptanceReviewList(by id: String) -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        Just([AcceptanceReview.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAllAcceptanceReviewList() -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        Just([AcceptanceReview.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchHotAcceptanceReviewList() -> AnyPublisher<[Domain.AcceptanceReview], any Error> {
        Just([AcceptanceReview.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchReview() -> AnyPublisher<Domain.Review, any Error> {
        Just(Review.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchReviewList() -> AnyPublisher<[Domain.Review], any Error> {
        Just([Review.sample0, .sample1])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAcceptanceReview() -> AnyPublisher<Domain.AcceptanceReview, any Error> {
        Just(AcceptanceReview.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchPost() -> AnyPublisher<Domain.Post, any Error> {
        Just(Post.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchPostList(with filter: Post.Filter) -> AnyPublisher<[Domain.Post], any Error> {
        let postList: [Post]
        switch filter {
        case .all:
            postList = [
                .sample0,
            ]
        case .onlyQuestions:
            postList = [
                .sample1,
            ]
        case .excludeQuestions:
            postList = [
                .sample0,
            ]
        // 예상하지 못한 경우 모든 게시물 반환
        @unknown default:
            postList = [
                .sample0,
            ]
        }

        return Just(postList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMentoringPost() -> AnyPublisher<Domain.MentoringPost, any Error> {
        Just(MentoringPost.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMentoringPostList() -> AnyPublisher<[Domain.MentoringPost], any Error> {
        Just([MentoringPost.sample0])
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

    public func fetchAllServiceList() -> AnyPublisher<[any Service], any Error> {
        Just<[any Service]>([
            LessonService.sample0,
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
        ])
        .setFailureType(to: Error.self)
        .delay(for: 0.5, scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    public func fetchLessonServiceDetail() -> AnyPublisher<Domain.LessonService, any Error> {
        Just(LessonService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchAccompanistServiceDetail() -> AnyPublisher<Domain.AccompanistService, any Error> {
        Just(AccompanistService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchScoreCreationServiceDetail() -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        Just(ScoreCreationService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchMusicCreationServiceDetail() -> AnyPublisher<Domain.MusicCreationService, any Error> {
        Just(MusicCreationService.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchServiceDetail() -> AnyPublisher<any Domain.Service, any Error> {
        fatalError()
    }

    public func postLessonService(_ lessonService: Domain.LessonServiceCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postAccompanistService(_ accompanistService: Domain.AccompanistService) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postCompositionService(_ compositionService: Domain.ScoreCreationService) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postMusicCreationService(_ musicCreationService: Domain.MusicCreationService) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func fetchChattingRoomList() -> AnyPublisher<[Domain.ChattingRoom], any Error> {
        Just([ChattingRoom.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}
#endif
