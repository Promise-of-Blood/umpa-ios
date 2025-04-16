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
            #if DEBUG
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

    var useCase: Factory<UseCase> {
        Factory(self) {
            UseCaseImpl(
                serverRepository: self.serverRepository(),
                keychainRepository: self.keychainRepository()
            )
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

    var loginInteractor: Factory<LoginInteractor> {
        Factory(self) { LoginInteractorImpl() }
            .scope(.shared)
    }

    var signUpInteractor: Factory<SignUpInteractor> {
        Factory(self) {
            #if DEBUG
            MockSignUpInteractor()
            #else
            SignUpInteractorImpl()
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
        Factory(self) {
            ChatInteractorImpl(
                appState: self.appState(),
                serverRepository: self.serverRepository()
            )
        }
        .scope(.shared)
    }

    var serviceListInteractor: Factory<ServiceListInteractor> {
        Factory(self) {
            ServiceListInteractorImpl(serverRepository: self.serverRepository())
        }
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
