// Created for Umpa in 2025

import Combine
import Domain
import Foundation

#if MOCK
public struct StubServerRepository {
    public init() {}
}

extension StubServerRepository: ServerRepository {
    public func fetchChattingRoom(by id: Domain.ChattingRoom.Id) -> AnyPublisher<Domain.ChattingRoom, any Error> {
        Just(ChattingRoom.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchChattingRoom(for id: String) -> AnyPublisher<Domain.ChattingRoom?, any Error> {
        let chattingRoomList = [ChattingRoom.sample0]
        let matchedChattingRoom = chattingRoomList.first { chattingRoom in
            chattingRoom.relatedService.id == id
        }

        return Just(matchedChattingRoom)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func updateLikeStatus(_ isLiked: Bool, for id: String) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postReview(_ review: Domain.ReviewCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func fetchMyServiceList(with: Domain.AccessToken) -> AnyPublisher<[any Domain.Service], any Error> {
        Just([
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    public func fetchFavoriteServiceList() -> AnyPublisher<[any Domain.Service], any Error> {
        let allServices: [any Service] = [
            LessonService.sample0,
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
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

    public func fetchAllLessonAndServiceList() -> AnyPublisher<[any Service], any Error> {
        Just<[any Service]>([
            LessonService.sample0,
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
        ])
        .setFailureType(to: Error.self)
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
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postAccompanistService(_ accompanistService: Domain.AccompanistService) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postCompositionService(_ compositionService: Domain.ScoreCreationService) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postMusicCreationService(_ musicCreationService: Domain.MusicCreationService) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchChattingRoomList() -> AnyPublisher<[Domain.ChattingRoom], any Error> {
        Just([ChattingRoom.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
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
