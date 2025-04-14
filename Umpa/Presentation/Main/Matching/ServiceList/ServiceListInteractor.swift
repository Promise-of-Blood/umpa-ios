// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol ServiceListInteractor {
    func loadAll(_ serviceList: Binding<[any Service]>)
    func load(_ serviceList: Binding<[any Service]>, for serviceType: ServiceType)

    func load(_ lessonServices: Binding<[LessonService]>)
    func load(_ accompanistServices: Binding<[AccompanistService]>)
    func load(_ compositionServices: Binding<[ScoreCreationService]>)
    func load(_ musicCreationServices: Binding<[MusicCreationService]>)

    func loadFavoriteServices(_ services: Binding<[any Service]>)
}

struct DefaultServiceListInteractor {
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()
}

extension DefaultServiceListInteractor: ServiceListInteractor {
    func loadFavoriteServices(_ services: Binding<[any Service]>) {
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

    func loadAll(_ serviceList: Binding<[any Service]>) {
        serverRepository.fetchAllLessonAndServiceList()
            .replaceError(with: [])
            .sink(serviceList)
            .store(in: cancelBag)
    }

    func load(_ serviceList: Binding<[any Service]>, for serviceType: ServiceType) {
        serverRepository.fetchAllLessonAndServiceList()
            .replaceError(with: [])
            .map { $0.filter { $0.type == serviceType } }
            .sink(serviceList)
            .store(in: cancelBag)
    }
}
