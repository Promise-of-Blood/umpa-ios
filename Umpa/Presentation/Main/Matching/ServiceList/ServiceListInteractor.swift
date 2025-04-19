// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

@MainActor
protocol ServiceListInteractor {
    func loadAll(_ serviceList: Binding<[AnyService]>)
    func load(_ serviceList: Binding<[AnyService]>, for serviceType: ServiceType)

    func load(_ lessonServices: Binding<[LessonService]>)
    func load(_ accompanistServices: Binding<[AccompanistService]>)
    func load(_ compositionServices: Binding<[ScoreCreationService]>)
    func load(_ musicCreationServices: Binding<[MusicCreationService]>)

    func loadFavoriteServices(_ services: Binding<[AnyService]>)
}

struct DefaultServiceListInteractor {
    private let serverRepository: ServerRepository

    private let cancelBag = CancelBag()

    init(serverRepository: ServerRepository) {
        self.serverRepository = serverRepository
    }
}

extension DefaultServiceListInteractor: ServiceListInteractor {
    func loadFavoriteServices(_ services: Binding<[AnyService]>) {
        serverRepository.fetchFavoriteServiceList()
            .replaceError(with: [])
            .sink(services)
            .store(in: cancelBag)
    }

    func load(_ lessonServices: Binding<[LessonService]>) {
        serverRepository.fetchLessonServiceList()
            .replaceError(with: [])
            .sink(lessonServices)
            .store(in: cancelBag)
    }

    func load(_ accompanistServices: Binding<[AccompanistService]>) {
        serverRepository.fetchAccompanistServiceList()
            .replaceError(with: [])
            .sink(accompanistServices)
            .store(in: cancelBag)
    }

    func load(_ compositionServices: Binding<[ScoreCreationService]>) {
        serverRepository.fetchScoreCreationServiceList()
            .replaceError(with: [])
            .sink(compositionServices)
            .store(in: cancelBag)
    }

    func load(_ musicCreationServices: Binding<[MusicCreationService]>) {
        serverRepository.fetchMusicCreationServiceList()
            .replaceError(with: [])
            .sink(musicCreationServices)
            .store(in: cancelBag)
    }

    func loadAll(_ serviceList: Binding<[AnyService]>) {
        serverRepository.fetchAllLessonAndServiceList()
            .replaceError(with: [])
            .sink(serviceList)
            .store(in: cancelBag)
    }

    func load(_ serviceList: Binding<[AnyService]>, for serviceType: ServiceType) {
        var anyServiceList: AnyPublisher<[AnyService], Error>

        switch serviceType {
        case .lesson:
            anyServiceList = serverRepository.fetchLessonServiceList()
                .map { $0.map { $0.eraseToAnyService() } }
                .eraseToAnyPublisher()
        case .accompanist:
            anyServiceList = serverRepository.fetchAccompanistServiceList()
                .map { $0.map { $0.eraseToAnyService() } }
                .eraseToAnyPublisher()
        case .scoreCreation:
            anyServiceList = serverRepository.fetchScoreCreationServiceList()
                .map { $0.map { $0.eraseToAnyService() } }
                .eraseToAnyPublisher()
        case .mrCreation:
            anyServiceList = serverRepository.fetchMusicCreationServiceList()
                .map { $0.map { $0.eraseToAnyService() } }
                .eraseToAnyPublisher()
        }

        anyServiceList
            .replaceError(with: [])
            .sink(serviceList)
            .store(in: cancelBag)
    }
}
