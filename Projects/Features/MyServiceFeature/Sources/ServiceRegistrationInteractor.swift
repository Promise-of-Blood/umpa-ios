// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation
import SwiftUI

@MainActor
protocol ServiceRegistrationInteractor {
  func post(_ lessonService: LessonServiceCreateData)
  func post(_ accompanistService: AccompanistServiceCreateData)
  func post(_ compositionService: ScoreCreationServiceCreateData)
  func post(_ musicCreationService: MusicCreationServiceCreateData)
}

struct DefaultServiceRegistrationInteractor {
  private let serviceRepository: ServiceRepository

  private let cancelBag = CancelBag()

  init(serviceRepository: ServiceRepository) {
    self.serviceRepository = serviceRepository
  }
}

extension DefaultServiceRegistrationInteractor: ServiceRegistrationInteractor {
  func post(_ accompanistService: Domain.AccompanistServiceCreateData) {
    serviceRepository.postAccompanistService(accompanistService)
      .sink { completion in
        if let error = completion.error {
          UmpaLogger.log(error.localizedDescription, level: .error)
        }
      } receiveValue: { _ in }
      .store(in: cancelBag)
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
