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
        Factory(self) { ReviewInteractorImpl() }
            .scope(.shared)
    }

    var serviceRegistrationInteractor: Factory<ServiceRegistrationInteractor> {
        Factory(self) { ServiceRegistrationInteractorImpl() }
            .scope(.shared)
    }

    var chatInteractor: Factory<ChatInteractor> {
        Factory(self) { ChatInteractorImpl() }
            .scope(.shared)
    }

    var serviceListInteractor: Factory<ServiceListInteractor> {
        Factory(self) { ServiceListInteractorImpl() }
            .scope(.shared)
    }

    var serviceDetailInteractor: Factory<ServiceDetailInteractor> {
        Factory(self) { ServiceDetailInteractorImpl() }
            .scope(.shared)
    }

    var teacherServiceManagementInteractor: Factory<TeacherServiceManagementInteractor> {
        Factory(self) { TeacherServiceManagementInteractorImpl() }
            .scope(.shared)
    }

    var teacherLessonManagementInteractor: Factory<TeacherLessonManagementInteractor> {
        Factory(self) { TeacherLessonManagementInteractorImpl() }
            .scope(.shared)
    }

    var notificationInteractor: Factory<UmpaNotificationInteractor> {
        Factory(self) { UmpaNotificationInteractorImpl() }
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
