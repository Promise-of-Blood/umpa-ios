// Created for Umpa in 2025

import Combine
import Domain
import Mockable
import Testing
@testable import Umpa
import Core

@Suite(.tags(.interactor))
final class ServiceListInteractorTests {
    var sut: ServiceListInteractor!
    var mockServerRepository: MockServerRepository!

    init() {
        mockServerRepository = MockServerRepository()
        sut = DefaultServiceListInteractor(serverRepository: mockServerRepository)
    }
}

extension ServiceListInteractorTests {
    @Test(arguments: [
        ServiceType.lesson,
        ServiceType.accompanist,
        ServiceType.mrCreation,
        ServiceType.scoreCreation,
    ])
    func loadServiceList(for serviceType: ServiceType) async throws {
        // Given
        let mockLessonList = [LessonService.sample0]
        let mockLessonListPublisher = Just(mockLessonList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let mockAccompanistList = [AccompanistService.sample0]
        let mockAccompanistListPublisher = Just(mockAccompanistList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let mockScoreCreationList = [ScoreCreationService.sample0]
        let mockScoreCreationListPublisher = Just(mockScoreCreationList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let mockMusicCreationList = [MusicCreationService.sample0]
        let mockMusicCreationListPublisher = Just(mockMusicCreationList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let serviceList = BindingWithPublisher([AnyService]())

        switch serviceType {
        case .lesson:
            given(mockServerRepository)
                .fetchLessonServiceList().willReturn(mockLessonListPublisher)
        case .accompanist:
            given(mockServerRepository)
                .fetchAccompanistServiceList().willReturn(mockAccompanistListPublisher)
        case .scoreCreation:
            given(mockServerRepository)
                .fetchScoreCreationServiceList().willReturn(mockScoreCreationListPublisher)
        case .mrCreation:
            given(mockServerRepository)
                .fetchMusicCreationServiceList().willReturn(mockMusicCreationListPublisher)
        }

        // When
        sut.load(serviceList.binding, for: serviceType)

        // Then
        let recorded = await serviceList.updatesRecorder.values.first(where: { _ in true })

        switch serviceType {
        case .lesson:
            #expect(recorded == [[], mockLessonList.map { $0.eraseToAnyService() }])
            verify(mockServerRepository)
                .fetchLessonServiceList().called(.once)
        case .accompanist:
            #expect(recorded == [[], mockAccompanistList.map { $0.eraseToAnyService() }])
            verify(mockServerRepository)
                .fetchAccompanistServiceList().called(.once)
        case .scoreCreation:
            #expect(recorded == [[], mockScoreCreationList.map { $0.eraseToAnyService() }])
            verify(mockServerRepository)
                .fetchScoreCreationServiceList().called(.once)
        case .mrCreation:
            #expect(recorded == [[], mockMusicCreationList.map { $0.eraseToAnyService() }])
            verify(mockServerRepository)
                .fetchMusicCreationServiceList().called(.once)
        }
    }
}
