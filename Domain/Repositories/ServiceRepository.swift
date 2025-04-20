// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol ServiceRepository {
    func fetchAllLessonAndServiceList() -> AnyPublisher<[AnyService], Error>

    /// 내가 등록한 레슨 목록을 가져옵니다.
    func fetchMyLessonList(with: AccessToken) -> AnyPublisher<[LessonService], Error>

    /// 레슨을 제외하고 내가 등록한 모든 서비스 목록을 가져옵니다.
    func fetchMyServiceList(with: AccessToken) -> AnyPublisher<[AnyService], Error>

    func fetchMyLessonAndServiceList(with: AccessToken) -> AnyPublisher<[AnyService], Error>

    /// 모든 레슨 목록을 가져옵니다.
    func fetchLessonServiceList() -> AnyPublisher<[LessonService], Error>
    func fetchAccompanistServiceList() -> AnyPublisher<[AccompanistService], Error>
    func fetchScoreCreationServiceList() -> AnyPublisher<[ScoreCreationService], Error>
    func fetchMusicCreationServiceList() -> AnyPublisher<[MusicCreationService], Error>

    func fetchLessonDetail(by id: LessonService.Id) -> AnyPublisher<LessonService, Error>
    func fetchAccompanistServiceDetail(by id: AnyService.Id) -> AnyPublisher<AccompanistService, Error>
    func fetchScoreCreationServiceDetail(by id: AnyService.Id) -> AnyPublisher<ScoreCreationService, Error>
    func fetchMusicCreationServiceDetail(by id: AnyService.Id) -> AnyPublisher<MusicCreationService, Error>
    func fetchServiceDetail(by id: AnyService.Id) -> AnyPublisher<AnyService, Error>

    func fetchFavoriteServiceList() -> AnyPublisher<[AnyService], Error>

    func postLessonService(_ lessonService: LessonServiceCreateData) -> AnyPublisher<Void, Error>
    func postAccompanistService(_ accompanistService: AccompanistServiceCreateData) -> AnyPublisher<Void, Error>
    func postCompositionService(_ compositionService: ScoreCreationServiceCreateData) -> AnyPublisher<Void, Error>
    func postMusicCreationService(_ musicCreationService: MusicCreationServiceCreateData) -> AnyPublisher<Void, Error>

    /// 해당 서비스의 좋아요 상태를 변경합니다.
    func updateLikeStatus(_ isLiked: Bool, for id: AnyService.Id) -> AnyPublisher<Void, Error>
}
