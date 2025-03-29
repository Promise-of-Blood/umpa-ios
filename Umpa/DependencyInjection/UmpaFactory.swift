// Created for Umpa in 2025

import Factory
import Networking
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

    var questionInteractor: Factory<QuestionInteractor> {
        Factory(self) { DefaultQuestionInteractor() }
            .scope(.shared)
    }

    var chatInteractor: Factory<ChatInteractor> {
        Factory(self) { DefaultChatInteractor() }
            .scope(.shared)
    }
}

// MARK: - ObservableObject

extension Container {
    var signUpModel: Factory<SignUpModel> {
        Factory(self) { SignUpModel() }
            .scope(.signUpSession)
    }

    var mainViewModel: Factory<MainView.Model> {
        Factory(self) { MainView.Model() }
            .scope(.mainSession)
    }
}
