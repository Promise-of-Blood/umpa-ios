// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

protocol ServiceRegistrationInteractor {
    func post(_ lessonService: LessonServiceCreateData)
    func post(_ accompanistService: AccompanistServiceCreateData)
    func post(_ compositionService: ScoreCreationServiceCreateData)
    func post(_ musicCreationService: MusicCreationServiceCreateData)
}

struct ServiceRegistrationInteractorImpl {
    @Injected(\.stubServerRepository) private var serverRepository

    private let cancelBag = CancelBag()
}

extension ServiceRegistrationInteractorImpl: ServiceRegistrationInteractor {
    func post(_ accompanistService: Domain.AccompanistServiceCreateData) {
        fatalError()
    }

    func post(_ compositionService: Domain.ScoreCreationServiceCreateData) {
        fatalError()
    }

    func post(_ musicCreationService: Domain.MusicCreationServiceCreateData) {
        fatalError()
    }

    func post(_ lessonService: LessonServiceCreateData) {
        fatalError()
    }
}
