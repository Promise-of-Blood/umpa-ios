// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol ServiceDetailInteractor {
    func markAsLike(_ isLiked: Bool, for id: Service.Id)
    func load(_ lesson: Binding<LessonService>, by id: LessonService.Id)
    func load(_ accompanistService: Binding<AccompanistService>, by id: Service.Id)
    func load(_ scoreCreationService: Binding<ScoreCreationService>, by id: Service.Id)
    func load(_ musicCreationService: Binding<MusicCreationService>, by id: Service.Id)
}

struct DefaultServiceDetailInteractor {
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()
}

extension DefaultServiceDetailInteractor: ServiceDetailInteractor {
    func markAsLike(_ isLiked: Bool, for id: Service.Id) {
        serverRepository.updateLikeStatus(isLiked, for: id)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .replaceError(with: ())
            .sink { _ in }
            .store(in: cancelBag)
    }

    func load(_ lesson: Binding<LessonService>, by id: LessonService.Id) {
        serverRepository.fetchLessonDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                lesson.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ accompanistService: Binding<Domain.AccompanistService>, by id: Service.Id) {
        serverRepository.fetchAccompanistServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                accompanistService.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ scoreCreationService: Binding<Domain.ScoreCreationService>, by id: Service.Id) {
        serverRepository.fetchScoreCreationServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                scoreCreationService.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ musicCreationService: Binding<Domain.MusicCreationService>, by id: Service.Id) {
        serverRepository.fetchMusicCreationServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                musicCreationService.wrappedValue = value
            }
            .store(in: cancelBag)
    }
}
