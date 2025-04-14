// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol ServiceInteractor {
    func loadMyLessonList(_ lessonList: Binding<[LessonService]>)
    func loadMyServiceList(_ serviceList: Binding<[any Service]>)

    func post(_ lessonService: LessonService)
    func post(_ accompanistService: AccompanistService)
    func post(_ compositionService: ScoreCreationService)
    func post(_ musicCreationService: MusicCreationService)
}

struct DefaultServiceInteractor {
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository

    private let cancelBag = CancelBag()
}

extension DefaultServiceInteractor: ServiceInteractor {
    func loadMyLessonList(_ lessonList: Binding<[Domain.LessonService]>) {
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyLessonList(with:))
            .replaceError(with: [])
            .sink(lessonList)
            .store(in: cancelBag)
    }

    func loadMyServiceList(_ serviceList: Binding<[any Domain.Service]>) {
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyServiceList(with:))
            .replaceError(with: [])
            .sink(serviceList)
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
}
