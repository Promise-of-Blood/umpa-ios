// Created for Umpa in 2025

import Combine

public protocol Repository {
    func fetchReview() -> AnyPublisher<Review, Error>
    func fetchReviewList() -> AnyPublisher<[Review], Error>

    func fetchAcceptanceReview() -> AnyPublisher<AcceptanceReview, Error>
    func fetchAcceptanceReviewList() -> AnyPublisher<[AcceptanceReview], Error>

    func fetchPost() -> AnyPublisher<Post, Error>
    func fetchPostList() -> AnyPublisher<[Post], Error>

    func fetchMentoringPost() -> AnyPublisher<MentoringPost, Error>
    func fetchMentoringPostList() -> AnyPublisher<[MentoringPost], Error>

    func fetchStudentData() -> AnyPublisher<Student, Error>
    func fetchTeacherData() -> AnyPublisher<Teacher, Error>

    func fetchServiceList() -> AnyPublisher<[any Service], Error>
    func fetchLessonServiceDetail() -> AnyPublisher<LessonService, Error>
    func fetchAccompanistServiceDetail() -> AnyPublisher<AccompanistService, Error>
    func fetchCompositionServiceDetail() -> AnyPublisher<ScoreCreationService, Error>
    func fetchMusicCreationServiceDetail() -> AnyPublisher<MusicCreationService, Error>
    func fetchServiceDetail() -> AnyPublisher<any Service, Error>

    func postLessonService(_ lessonService: LessonService) -> AnyPublisher<Void, Error>
    func postAccompanistService(_ accompanistService: AccompanistService) -> AnyPublisher<Void, Error>
    func postCompositionService(_ compositionService: ScoreCreationService) -> AnyPublisher<Void, Error>
    func postMusicCreationService(_ musicCreationService: MusicCreationService) -> AnyPublisher<Void, Error>

    func fetchChattingRoomList() -> AnyPublisher<[ChattingRoom], Error>

    func postChatMessage(_ message: ChatMessage) -> AnyPublisher<Void, Error>
}
