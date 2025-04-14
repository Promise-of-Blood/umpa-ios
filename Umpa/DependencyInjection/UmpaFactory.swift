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

    var serverRepository: Factory<ServerRepository> {
        Factory(self) {
            #if MOCK
            return StubServerRepository()
            #else
            return DefaultServerRepository()
            #endif
        }
        .scope(.singleton)
    }

    var keychainRepository: Factory<KeychainRepository> {
        Factory(self) { DefaultKeychainRepository() }
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
        Factory(self) {
            #if MOCK
            MockSignUpInteractor()
            #else
            DefaultSignUpInteractor()
            #endif
        }
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

    var serviceRegistrationInteractor: Factory<ServiceRegistrationInteractor> {
        Factory(self) { DefaultServiceRegistrationInteractor() }
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

    var serviceListInteractor: Factory<ServiceListInteractor> {
        Factory(self) { DefaultServiceListInteractor() }
            .scope(.shared)
    }

    var serviceDetailInteractor: Factory<ServiceDetailInteractor> {
        Factory(self) { DefaultServiceDetailInteractor() }
            .scope(.shared)
    }

    var teacherServiceManagementInteractor: Factory<TeacherServiceManagementInteractor> {
        Factory(self) { DefaultTeacherServiceManagementInteractor() }
            .scope(.shared)
    }

    var teacherLessonManagementInteractor: Factory<TeacherLessonManagementInteractor> {
        Factory(self) { DefaultTeacherLessonManagementInteractor() }
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
