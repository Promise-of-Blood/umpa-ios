// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol ServiceInteractor {
    @MainActor
    func load(_ lessonServices: Binding<[LessonService]>) async throws

    @MainActor
    func load(_ accompanistServices: Binding<[AccompanistService]>) async throws

    @MainActor
    func load(_ compositionServices: Binding<[CompositionService]>) async throws

    @MainActor
    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws

    @MainActor
    func post(_ lessonService: LessonService)

    @MainActor
    func post(_ accompanistService: AccompanistService)

    @MainActor
    func post(_ compositionService: CompositionService)

    @MainActor
    func post(_ musicCreationService: MusicCreationService)
}

struct DefaultServiceInteractor: ServiceInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ lessonServices: Binding<[LessonService]>) async throws {
        fatalError()
    }

    func load(_ accompanistServices: Binding<[AccompanistService]>) async throws {
        fatalError()
    }

    func load(_ compositionServices: Binding<[CompositionService]>) async throws {
        fatalError()
    }

    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws {
        fatalError()
    }

    func post(_ lessonService: LessonService) {
        fatalError()
    }

    func post(_ accompanistService: AccompanistService) {
        fatalError()
    }

    func post(_ compositionService: CompositionService) {
        fatalError()
    }

    func post(_ musicCreationService: MusicCreationService) {
        fatalError()
    }
}

#if DEBUG
struct MockServiceInteractor: ServiceInteractor {
    func load(_ lessonServices: Binding<[LessonService]>) async throws {
        lessonServices.wrappedValue = [
            LessonService.sample0,
        ]
    }

    func load(_ accompanistServices: Binding<[AccompanistService]>) async throws {
        accompanistServices.wrappedValue = [
            AccompanistService.sample0,
        ]
    }

    func load(_ compositionServices: Binding<[CompositionService]>) async throws {
        compositionServices.wrappedValue = [
            CompositionService.sample0,
        ]
    }

    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws {
        musicCreationServices.wrappedValue = [
            MusicCreationService.sample0,
        ]
    }

    func post(_ lessonService: LessonService) {}

    func post(_ accompanistService: AccompanistService) {}

    func post(_ compositionService: CompositionService) {}

    func post(_ musicCreationService: MusicCreationService) {}
}
#endif
