// Created for Umpa in 2025

import DataAccess
import Domain
import Factory

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

    var appRepository: Factory<AppRepository> {
        Factory(self) {
            DefaultAppRepository(
                network: self.network(),
            )
        }
        .scope(.singleton)
    }

    var jwtRepository: Factory<JwtRepository> {
        Factory(self) {
            DefaultJwtRepository(persistentStorage: self.keychainStorage())
        }
        .scope(.singleton)
    }

    var serviceRepository: Factory<ServiceRepository> {
        Factory(self) {
            DefaultServiceRepository()
        }
        .scope(.singleton)
    }

    var chatRepository: Factory<ChatRepository> {
        Factory(self) {
            DefaultChatRepository(
                network: self.network(),
            )
        }
        .scope(.singleton)
    }

    var reviewRepository: Factory<ReviewRepository> {
        Factory(self) {
            DefaultReviewRepository()
        }
        .scope(.singleton)
    }

    var umpaNotificationRepository: Factory<UmpaNotificationRepository> {
        Factory(self) {
            DefaultUmpaNotificationRepository()
        }
        .scope(.singleton)
    }

    var userRepository: Factory<UserRepository> {
        Factory(self) {
            DefaultUserRepository()
        }
        .scope(.singleton)
    }

    // MARK: - DataAccess

    var keychainStorage: Factory<PersistentStorage> {
        Factory(self) {
            #if DEBUG
            KeychainStorage(serviceName: "com.pob.Umpa.Test.Debug")
            #else
            KeychainStorage(serviceName: "com.pob.Umpa")
            #endif
        }
        .scope(.singleton)
    }

    var network: Factory<Network> {
        Factory(self) {
            DefaultNetwork(session: .shared)
        }
        .scope(.singleton)
    }

    // MARK: - UseCase

    var signUpUseCase: Factory<SignUpUseCase> {
        Factory(self) {
            DefaultSignUpUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    var checkAccountLinkedSocialIdUseCase: Factory<CheckAccountLinkedSocialIdUseCase> {
        Factory(self) {
            DefaultCheckAccountLinkedSocialIdUseCase(
                jwtRepository: self.jwtRepository()
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
            DefaultLoginInteractor(
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
        Factory(self) {
            DefaultServiceRegistrationInteractor(
                serviceRepository: self.serviceRepository(),
            )
        }
        .scope(.shared)
    }

    var chatInteractor: Factory<ChatInteractor> {
        Factory(self) {
            DefaultChatInteractor(
                appState: self.appState(),
                chatRepository: self.chatRepository(),
            )
        }
        .scope(.shared)
    }

    var serviceListInteractor: Factory<ServiceListInteractor> {
        Factory(self) {
            DefaultServiceListInteractor(
                serviceRepository: self.serviceRepository(),
            )
        }
        .scope(.shared)
    }

    var serviceDetailInteractor: Factory<ServiceDetailInteractor> {
        Factory(self) {
            DefaultServiceDetailInteractor(
                appState: self.appState(),
                serviceRepository: self.serviceRepository(),
                chatRepository: self.chatRepository(),
            )
        }
        .scope(.shared)
    }

    var teacherServiceManagementInteractor: Factory<TeacherServiceManagementInteractor> {
        Factory(self) {
            DefaultTeacherServiceManagementInteractor(
                appState: self.appState(),
                serviceRepository: self.serviceRepository(),
                chatRepository: self.chatRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase(),
            )
        }
        .scope(.shared)
    }

    var teacherLessonManagementInteractor: Factory<TeacherLessonManagementInteractor> {
        Factory(self) {
            DefaultTeacherLessonManagementInteractor(
                appState: self.appState(),
                serviceRepository: self.serviceRepository(),
                chatRepository: self.chatRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase(),
            )
        }
        .scope(.shared)
    }

    var teacherHomeInteractor: Factory<TeacherHomeInteractor> {
        Factory(self) {
            DefaultTeacherHomeInteractor(
                serviceRepository: self.serviceRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase(),
            )
        }
        .scope(.shared)
    }

    var umpaNotificationInteractor: Factory<UmpaNotificationInteractor> {
        Factory(self) {
            DefaultUmpaNotificationInteractor(
                umpaNotificationRepository: self.umpaNotificationRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase()
            )
        }
        .scope(.shared)
    }

    var myProfileInteractor: Factory<MyProfileInteractor> {
        Factory(self) {
            DefaultMyProfileInteractor(
                appState: self.appState()
            )
        }
        .scope(.shared)
    }
}
