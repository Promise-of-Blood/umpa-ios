// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultServerRepository {
    public init() {}
}

extension DefaultServerRepository: ServerRepository {
    public func fetchMyLessonAndServiceList(with: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
        fatalError()
    }

    public func fetchMyNotificationList(with: Domain.AccessToken) -> AnyPublisher<[Domain.UmpaNotification], any Error> {
        fatalError()
    }

    public func fetchLessonDetail(by id: Domain.LessonService.Id) -> AnyPublisher<Domain.LessonService, any Error> {
        fatalError()
    }

    public func fetchAccompanistServiceDetail(by id: String) -> AnyPublisher<Domain.AccompanistService, any Error> {
        fatalError()
    }

    public func fetchScoreCreationServiceDetail(by id: String) -> AnyPublisher<Domain.ScoreCreationService, any Error> {
        fatalError()
    }

    public func fetchMusicCreationServiceDetail(by id: String) -> AnyPublisher<Domain.MusicCreationService, any Error> {
        fatalError()
    }

    public func fetchServiceDetail(by id: String) -> AnyPublisher<AnyService, any Error> {
        fatalError()
    }

    public func postAcceptanceReviewComment(_ comment: Domain.AcceptanceReviewCommentCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func fetchChatRoom(by id: Domain.ChatRoom.Id) -> AnyPublisher<Domain.ChatRoom, any Error> {
        fatalError()
    }

    public func fetchChatRoom(for id: String) -> AnyPublisher<Domain.ChatRoom?, any Error> {
        fatalError()
    }

    public func updateLikeStatus(_ isLiked: Bool, for id: String) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func postReview(_ review: Domain.ReviewCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

    public func fetchMyServiceList(with: Domain.AccessToken) -> AnyPublisher<[AnyService], any Error> {
        fatalError()
    }

    public func fetchMyLessonList(with: AccessToken) -> AnyPublisher<[Domain.LessonService], any Error> {
        fatalError()
    }

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

    public func fetchFavoriteServiceList() -> AnyPublisher<[AnyService], any Error> {
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

    public func fetchAllLessonAndServiceList() -> AnyPublisher<[AnyService], any Error> {
        fatalError("fetchAllServiceList() has not been implemented")
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

    public func fetchChatRoomList() -> AnyPublisher<[Domain.ChatRoom], any Error> {
        fatalError()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        fatalError("postChatMessage() has not been implemented")
    }
}
