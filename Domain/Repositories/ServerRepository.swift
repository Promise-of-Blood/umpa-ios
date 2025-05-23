// Created for Umpa in 2025

import Combine

public protocol ServerRepository {
    func fetchMajorList() -> AnyPublisher<[Major], Error>

    func fetchReview() -> AnyPublisher<Review, Error>
    func fetchReviewList() -> AnyPublisher<[Review], Error>

    func postReview(_ review: ReviewCreateData) -> AnyPublisher<Void, Error>

    func fetchAcceptanceReview() -> AnyPublisher<AcceptanceReview, Error>
    func fetchAcceptanceReviewList(by id: String) -> AnyPublisher<[AcceptanceReview], Error>
    func fetchAllAcceptanceReviewList() -> AnyPublisher<[AcceptanceReview], Error>
    func fetchHotAcceptanceReviewList() -> AnyPublisher<[AcceptanceReview], Error>

    func postAcceptanceReviewComment(_ comment: AcceptanceReviewCommentCreateData) -> AnyPublisher<Void, Error>

    func fetchAcceptanceReviewCommentList(by id: AcceptanceReview.ID) -> AnyPublisher<[AcceptanceReview.Comment], Error>

    func fetchPost() -> AnyPublisher<Post, Error>
    func fetchPostList(with filter: Post.Filter) -> AnyPublisher<[Post], Error>
    func fetchHotPostList() -> AnyPublisher<[Post], Error>

    func fetchMentoringPost() -> AnyPublisher<MentoringPost, Error>
    func fetchMentoringPostList() -> AnyPublisher<[MentoringPost], Error>

    func fetchStudentData() -> AnyPublisher<Student, Error>
    func fetchTeacherData() -> AnyPublisher<Teacher, Error>

    func fetchAllLessonAndServiceList() -> AnyPublisher<[any Service], Error>

    /// 내가 등록한 레슨 목록을 가져옵니다.
    func fetchMyLessonList(with: AccessToken) -> AnyPublisher<[LessonService], Error>

    /// 레슨을 제외하고 내가 등록한 모든 서비스 목록을 가져옵니다.
    func fetchMyServiceList(with: AccessToken) -> AnyPublisher<[any Service], Error>

    func fetchMyLessonAndServiceList(with: AccessToken) -> AnyPublisher<[any Service], Error>

    /// 모든 레슨 목록을 가져옵니다.
    func fetchLessonServiceList() -> AnyPublisher<[LessonService], Error>
    func fetchAccompanistServiceList() -> AnyPublisher<[AccompanistService], Error>
    func fetchScoreCreationServiceList() -> AnyPublisher<[ScoreCreationService], Error>
    func fetchMusicCreationServiceList() -> AnyPublisher<[MusicCreationService], Error>

    func fetchLessonDetail(by id: LessonService.Id) -> AnyPublisher<LessonService, Error>
    func fetchAccompanistServiceDetail(by id: Service.Id) -> AnyPublisher<AccompanistService, Error>
    func fetchScoreCreationServiceDetail(by id: Service.Id) -> AnyPublisher<ScoreCreationService, Error>
    func fetchMusicCreationServiceDetail(by id: Service.Id) -> AnyPublisher<MusicCreationService, Error>
    func fetchServiceDetail(by id: Service.Id) -> AnyPublisher<any Service, Error>

    func fetchFavoriteServiceList() -> AnyPublisher<[any Service], Error>

    func postLessonService(_ lessonService: LessonServiceCreateData) -> AnyPublisher<Void, Error>
    func postAccompanistService(_ accompanistService: AccompanistService) -> AnyPublisher<Void, Error>
    func postCompositionService(_ compositionService: ScoreCreationService) -> AnyPublisher<Void, Error>
    func postMusicCreationService(_ musicCreationService: MusicCreationService) -> AnyPublisher<Void, Error>

    func fetchChatRoomList() -> AnyPublisher<[ChatRoom], Error>
    func fetchChatRoom(for id: Service.Id) -> AnyPublisher<ChatRoom?, Error>
    func fetchChatRoom(by id: ChatRoom.Id) -> AnyPublisher<ChatRoom, Error>

    func postChatMessage(_ message: ChatMessage) -> AnyPublisher<Void, Error>

    func updateLikeStatus(_ isLiked: Bool, for id: Service.Id) -> AnyPublisher<Void, Error>

    func fetchMyNotificationList(with: AccessToken) -> AnyPublisher<[UmpaNotification], Error>
}
