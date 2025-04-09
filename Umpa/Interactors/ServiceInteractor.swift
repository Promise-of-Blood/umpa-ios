// Created for Umpa in 2025

import Factory
import Foundation
import DataAccess
import SwiftUI

protocol ServiceInteractor {
    @MainActor
    func load(_ lessonServices: Binding<[LessonService]>) async throws

    @MainActor
    func load(_ accompanistServices: Binding<[AccompanistService]>) async throws

    @MainActor
    func load(_ compositionServices: Binding<[ScoreCreationService]>) async throws

    @MainActor
    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws

    @MainActor
    func load(_ services: Binding<[any Service]>) async throws

    @MainActor
    func loadServices() async throws -> [any Service]

    @MainActor
    func load(_ services: Binding<[any Service]>, for serviceType: ServiceType) async throws

    @MainActor
    func loadServices(for serviceType: ServiceType) async throws -> [any Service]

    @MainActor
    func loadFavoriteServices(_ services: Binding<[any Service]>) async throws

    @MainActor
    func post(_ lessonService: LessonService)

    @MainActor
    func post(_ accompanistService: AccompanistService)

    @MainActor
    func post(_ compositionService: ScoreCreationService)

    @MainActor
    func post(_ musicCreationService: MusicCreationService)

    @MainActor
    func markAsLike(_ isLiked: Bool, for id: Service.Id) async throws
}

struct DefaultServiceInteractor: ServiceInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ lessonServices: Binding<[LessonService]>) async throws {
        fatalError()
    }

    func load(_ accompanistServices: Binding<[AccompanistService]>) async throws {
        fatalError()
    }

    func load(_ compositionServices: Binding<[ScoreCreationService]>) async throws {
        fatalError()
    }

    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws {
        fatalError()
    }

    func load(_ services: Binding<[any Service]>) async throws {
        fatalError()
    }

    func loadServices() async throws -> [any Service] {
        fatalError()
    }

    func load(_ services: Binding<[any Service]>, for serviceType: ServiceType) async throws {
        fatalError()
    }

    func loadFavoriteServices(_ services: Binding<[any Service]>) async throws {
        fatalError()
    }

    func loadServices(for serviceType: ServiceType) async throws -> [any Service] {
        fatalError()
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

    func markAsLike(_ isLiked: Bool, for id: Service.Id) async throws {
        fatalError()
    }
}

#if MOCK
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

    func load(_ compositionServices: Binding<[ScoreCreationService]>) async throws {
        compositionServices.wrappedValue = [
            ScoreCreationService.sample0,
        ]
    }

    func load(_ musicCreationServices: Binding<[MusicCreationService]>) async throws {
        musicCreationServices.wrappedValue = [
            MusicCreationService.sample0,
        ]
    }

    func loadServices() async throws -> [any Service] {
        return [
            LessonService.sample0,
            AccompanistService.sample0,
            ScoreCreationService.sample0,
            MusicCreationService.sample0,
        ]
    }

    func load(_ services: Binding<[any Service]>) async throws {
        services.wrappedValue = try await loadServices()
    }

    func load(_ services: Binding<[any Service]>, for serviceType: ServiceType) async throws {
        services.wrappedValue = try await loadServices(for: serviceType)
    }

    func loadServices(for serviceType: ServiceType) async throws -> [any Service] {
        switch serviceType {
        case .lesson:
            return [
                LessonService.sample0,
            ]
        case .accompanist:
            return [
                AccompanistService.sample0,
            ]
        case .scoreCreation:
            return [
                ScoreCreationService.sample0,
            ]
        case .mrCreation:
            return [
                MusicCreationService.sample0,
            ]
        }
    }

    func loadFavoriteServices(_ services: Binding<[any Service]>) async throws {
        let allServices = try await loadServices()

        let favoriteServices = allServices.filter { service in
            guard let serviceId = service.id else { return false }
            return Student.sample0.favoriteServices.contains(serviceId)
        }

        services.wrappedValue = favoriteServices
    }

    func post(_ lessonService: LessonService) {}

    func post(_ accompanistService: AccompanistService) {}

    func post(_ compositionService: ScoreCreationService) {}

    func post(_ musicCreationService: MusicCreationService) {}

    func markAsLike(_ isLiked: Bool, for id: Service.Id) async throws {}
}
#endif
