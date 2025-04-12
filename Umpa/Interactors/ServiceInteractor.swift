// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol ServiceInteractor {
    func load(_ lessonServices: Binding<[LessonService]>)
    func load(_ accompanistServices: Binding<[AccompanistService]>)
    func load(_ compositionServices: Binding<[ScoreCreationService]>)
    func load(_ musicCreationServices: Binding<[MusicCreationService]>)
    func load(_ services: Binding<[any Service]>)
    func load(_ services: Binding<[any Service]>, for serviceType: ServiceType)
    func loadFavoriteServices(_ services: Binding<[any Service]>)
    func post(_ lessonService: LessonService)
    func post(_ accompanistService: AccompanistService)
    func post(_ compositionService: ScoreCreationService)
    func post(_ musicCreationService: MusicCreationService)
    func markAsLike(_ isLiked: Bool, for id: Service.Id)
}

struct DefaultServiceInteractor: ServiceInteractor {
    @Injected(\.serverRepository) private var serverRepository

    let cancelBag = CancelBag()

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

    func load(_ services: Binding<[any Service]>) {
        serverRepository.fetchAllServiceList()
            .replaceError(with: [])
            .sink(services)
            .store(in: cancelBag)
    }

    func load(_ services: Binding<[any Service]>, for serviceType: ServiceType) {
        serverRepository.fetchAllServiceList()
            .replaceError(with: [])
            .map { $0.filter { $0.type == serviceType } }
            .sink(services)
            .store(in: cancelBag)
    }

    func loadFavoriteServices(_ services: Binding<[any Service]>) {
        serverRepository.fetchFavoriteServiceList()
            .replaceError(with: [])
            .sink(services)
            .store(in: cancelBag)
    }

    func post(_ lessonService: LessonService) {
        fatalError()
    }

    func post(_ accompanistService: AccompanistService) {
        fatalError()
    }

    func post(_ compositionService: ScoreCreationService) {
        fatalError()
    }

    func post(_ musicCreationService: MusicCreationService) {
        fatalError()
    }

    func markAsLike(_ isLiked: Bool, for id: Service.Id) {
        fatalError()
    }
}
