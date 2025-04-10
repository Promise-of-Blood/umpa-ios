// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import SwiftUI

extension Scope {
    static let signUpSession = Cached()
    static let mainSession = Cached()
}

// MARK: - Common

extension Container {
    var appState: Factory<AppState> {
        Factory(self) { AppState() }
            .scope(.singleton)
    }

    var umpaApi: Factory<UmpaApi> {
        Factory(self) { UmpaApi() }
            .scope(.singleton)
    }

    var serverRepository: Factory<Repository> {
        Factory(self) {
            #if MOCK
            return MockServerRepository()
            #else
            return ServerRepository()
            #endif
        }
        .scope(.singleton)
    }
}

// MARK: - Interactor

extension Container {
    var appInteractor: Factory<AppInteractor> {
        Factory(self) { DefaultAppInteractor() }
            .scope(.singleton)
    }

    var signUpInteractor: Factory<SignUpInteractor> {
        Factory(self) { DefaultSignUpInteractor() }
            .scope(.shared)
    }

    var reviewInteractor: Factory<ReviewInteractor> {
        Factory(self) { DefaultReviewInteractor() }
            .scope(.shared)
    }

    var acceptanceReviewInteractor: Factory<AcceptanceReviewInteractor> {
        Factory(self) { DefaultAcceptanceReviewInteractor() }
            .scope(.shared)
    }

    var serviceInteractor: Factory<ServiceInteractor> {
        Factory(self) { DefaultServiceInteractor() }
            .scope(.shared)
    }

    var chatInteractor: Factory<ChatInteractor> {
        Factory(self) { DefaultChatInteractor() }
            .scope(.shared)
    }

    var generalBoardInteractor: Factory<GeneralBoardInteractor> {
        Factory(self) { DefaultGeneralBoardInteractor() }
            .scope(.shared)
    }

    var mentoringInteractor: Factory<MentoringInteractor> {
        Factory(self) { DefaultMentoringInteractor() }
            .scope(.shared)
    }
}

// MARK: - ObservableObject

extension Container {
    var signUpModel: Factory<SignUpModel> {
        Factory(self) { SignUpModel() }
            .scope(.signUpSession)
    }
}
