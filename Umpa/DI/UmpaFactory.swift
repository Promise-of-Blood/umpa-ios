// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import SwiftUI

extension Scope {
    static let signUpSession = Cached()
    static let mainSession = Cached()
}

extension Container {
    // MARK: - Common

    var appState: Factory<AppState> {
        Factory(self) { AppState() }
            .scope(.singleton)
    }

    // MARK: - Repository

    var serverRepository: Factory<ServerRepository> {
        Factory(self) {
            DefaultServerRepository()
        }
        .scope(.singleton)
    }

    var jwtRepository: Factory<JwtRepository> {
        Factory(self) {
            DefaultJwtRepository(persistentStorage: self.keychainStorage())
        }
        .scope(.singleton)
    }

    // MARK: - DataAccess

    var umpaApi: Factory<UmpaApi> {
        Factory(self) { UmpaApi() }
            .scope(.singleton)
    }

    var keychainStorage: Factory<PersistentStorage> {
        Factory(self) {
            KeychainStorage(serviceName: "com.pob.Umpa")
        }
        .scope(.singleton)
    }

    // MARK: - UseCase

    var signUpUseCase: Factory<SignUpUseCase> {
        Factory(self) {
            DefaultSignUpUseCase(
                serverRepository: self.serverRepository(),
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    var checkAccountLinkedSocialIdUseCase: Factory<CheckAccountLinkedSocialIdUseCase> {
        Factory(self) {
            DefaultCheckAccountLinkedSocialIdUseCase(
                serverRepository: self.serverRepository()
            )
        }
        .scope(.singleton)
    }

    var getAccessTokenUseCase: Factory<GetAccessTokenUseCase> {
        Factory(self) {
            DefaultGetAccessTokenUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    var setAccessTokenUseCase: Factory<SetAccessTokenUseCase> {
        Factory(self) {
            DefaultSetAccessTokenUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    // MARK: - Interactor

    var appInteractor: Factory<AppInteractor> {
        Factory(self) { DefaultAppInteractor() }
            .scope(.singleton)
    }

    var loginInteractor: Factory<LoginInteractor> {
        Factory(self) {
            LoginInteractorImpl(
                appState: self.appState(),
                checkAccountLinkedSocialIdUseCase: self.checkAccountLinkedSocialIdUseCase()
            )
        }
        .scope(.shared)
    }

    var signUpInteractor: Factory<SignUpInteractor> {
        Factory(self) {
            SignUpInteractorImpl(
                appState: self.appState(),
                signUpUseCase: self.signUpUseCase()
            )
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
        Factory(self) {
            ServiceDetailInteractorImpl(
                appState: self.appState(),
                serverRepository: self.serverRepository()
            )
        }
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

    var myProfileInteractor: Factory<MyProfileInteractor> {
        Factory(self) {
            MyProfileInteractorImpl(
                appState: self.appState()
            )
        }
        .scope(.shared)
    }
}

// MARK: - Mock

#if DEBUG

extension Container {
    var mockServerRepository: Factory<ServerRepository> {
        Factory(self) { MockServerRepository() }
            .scope(.singleton)
    }

    var stubServerRepository: Factory<ServerRepository> {
        Factory(self) { StubServerRepository() }
            .scope(.singleton)
    }

    var mockSignUpUseCase: Factory<SignUpUseCase> {
        Factory(self) { MockSignUpUseCase() }
            .scope(.singleton)
    }

    var mockCheckAccountLinkedSocialIdUseCase: Factory<CheckAccountLinkedSocialIdUseCase> {
        Factory(self) { MockCheckAccountLinkedSocialIdUseCase() }
            .scope(.singleton)
    }

    var mockLoginInteractor: Factory<LoginInteractor> {
        Factory(self) {
            LoginInteractorImpl(
                appState: self.appState(),
                checkAccountLinkedSocialIdUseCase: self.mockCheckAccountLinkedSocialIdUseCase()
            )
        }
        .scope(.shared)
    }

    var mockSignUpInteractor: Factory<SignUpInteractor> {
        Factory(self) {
            SignUpInteractorImpl(
                appState: self.appState(),
                signUpUseCase: self.mockSignUpUseCase()
            )
        }
        .scope(.shared)
    }

    var stubServiceListInteractor: Factory<ServiceListInteractor> {
        Factory(self) {
            ServiceListInteractorImpl(serverRepository: self.stubServerRepository())
        }
        .scope(.shared)
    }

    var stubChatInteractor: Factory<ChatInteractor> {
        Factory(self) {
            ChatInteractorImpl(
                appState: self.appState(),
                serverRepository: self.stubServerRepository()
            )
        }
        .scope(.shared)
    }

    var stubServiceDetailInteractor: Factory<ServiceDetailInteractor> {
        Factory(self) {
            ServiceDetailInteractorImpl(
                appState: self.appState(),
                serverRepository: self.stubServerRepository()
            )
        }
        .scope(.shared)
    }
}

#endif
