// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct ServerRepository: Repository {
    public init() {}

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

    public func fetchServiceList() -> AnyPublisher<[any Domain.Service], any Error> {
        fatalError("fetchServiceList() has not been implemented")
    }

    public func fetchLessonServiceDetail() -> AnyPublisher<Domain.LessonService, any Error> {
        fatalError("fetchLessonServiceDetail() has not been implemented")
    }

    public func fetchAccompanistServiceDetail() -> AnyPublisher<Domain.AccompanistService, any Error> {
        fatalError("fetchAccompanistServiceDetail() has not been implemented")
    }

    public func fetchCompositionServiceDetail() -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        fatalError("fetchCompositionServiceDetail() has not been implemented")
    }

    public func fetchMusicCreationServiceDetail() -> AnyPublisher<Domain.MusicCreationService, any Error> {
        fatalError("fetchMusicCreationServiceDetail() has not been implemented")
    }

    public func fetchServiceDetail() -> AnyPublisher<any Domain.Service, any Error> {
        fatalError("fetchServiceDetail() has not been implemented")
    }

    public func postLessonService(_ lessonService: Domain.LessonService) -> AnyPublisher<Void, any Error> {
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
        fatalError("fetchChattingRoomList() has not been implemented")
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        fatalError("postChatMessage() has not been implemented")
    }
}
