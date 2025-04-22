// Created for Umpa in 2025

import DataAccess
import Domain
import Factory

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
}

// MARK: - Repository

extension Container {
    private var appRepository: Factory<AppRepository> {
        Factory(self) {
            DefaultAppRepository(
                network: self.network(),
            )
        }
        .scope(.singleton)
    }

    private var jwtRepository: Factory<JwtRepository> {
        Factory(self) {
            DefaultJwtRepository(persistentStorage: self.keychainStorage())
        }
        .scope(.singleton)
    }

    private var serviceRepository: Factory<ServiceRepository> {
        Factory(self) {
            DefaultServiceRepository()
        }
        .scope(.singleton)
    }

    private var chatRepository: Factory<ChatRepository> {
        Factory(self) {
            DefaultChatRepository(
                network: self.network(),
            )
        }
        .scope(.singleton)
    }

    private var reviewRepository: Factory<ReviewRepository> {
        Factory(self) {
            DefaultReviewRepository()
        }
        .scope(.singleton)
    }

    private var umpaNotificationRepository: Factory<UmpaNotificationRepository> {
        Factory(self) {
            DefaultUmpaNotificationRepository()
        }
        .scope(.singleton)
    }

    private var userRepository: Factory<UserRepository> {
        Factory(self) {
            DefaultUserRepository()
        }
        .scope(.singleton)
    }
}

// MARK: - DataAccess

extension Container {
    private var keychainStorage: Factory<PersistentStorage> {
        Factory(self) {
            #if DEBUG
            KeychainStorage(serviceName: "com.pob.Umpa.Test.Debug")
            #else
            KeychainStorage(serviceName: "com.pob.Umpa")
            #endif
        }
        .scope(.singleton)
    }

    private var network: Factory<Network> {
        Factory(self) {
            DefaultNetwork(session: .shared)
        }
        .scope(.singleton)
    }
}

// MARK: - UseCase

extension Container {
    private var signUpUseCase: Factory<SignUpUseCase> {
        Factory(self) {
            DefaultSignUpUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    private var sendPhoneVerificationCodeUseCase: Factory<SendPhoneVerificationCodeUseCase> {
        Factory(self) {
            DefaultSendPhoneVerificationCodeUseCase()
        }
        .scope(.singleton)
    }

    private var checkAccountLinkedSocialIdUseCase: Factory<CheckAccountLinkedSocialIdUseCase> {
        Factory(self) {
            DefaultCheckAccountLinkedSocialIdUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    private var getAccessTokenUseCase: Factory<GetAccessTokenUseCase> {
        Factory(self) {
            DefaultGetAccessTokenUseCase(
                jwtRepository: self.jwtRepository()
            )
        }
        .scope(.singleton)
    }

    private var setAccessTokenUseCase: Factory<SetAccessTokenUseCase> {
        Factory(self) {
            DefaultSetAccessTokenUseCase(
                jwtRepository: self.jwtRepository()
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

    var phoneVerificationInteractor: Factory<PhoneVerificationInteractor> {
        Factory(self) {
            DefaultPhoneVerificationInteractor(
                appState: self.appState(),
                sendPhoneVerificationCode: self.sendPhoneVerificationCodeUseCase(),
            )
        }
        .scope(.shared)
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

#if DEBUG

// MARK: - Mock

// MARK: - Repository

extension Container {
    var stubAppRepository: Factory<AppRepository> {
        Factory(self) {
            StubAppRepository()
        }
        .scope(.singleton)
    }

    var stubServiceRepository: Factory<ServiceRepository> {
        Factory(self) {
            StubServiceRepository()
        }
        .scope(.singleton)
    }

    var stubChatRepository: Factory<ChatRepository> {
        Factory(self) {
            StubChatRepository()
        }
        .scope(.singleton)
    }

    var stubUmpaNotificationRepository: Factory<UmpaNotificationRepository> {
        Factory(self) {
            StubUmpaNotificationRepository()
        }
        .scope(.singleton)
    }

    var stubReviewRepository: Factory<ReviewRepository> {
        Factory(self) {
            StubReviewRepository()
        }
        .scope(.singleton)
    }
}

// MARK: - UseCase

extension Container {
    var mockSignUpUseCase: Factory<SignUpUseCase> {
        Factory(self) { MockSignUpUseCase() }
            .scope(.singleton)
    }

    var mockCheckAccountLinkedSocialIdUseCase: Factory<CheckAccountLinkedSocialIdUseCase> {
        Factory(self) { MockCheckAccountLinkedSocialIdUseCase() }
            .scope(.singleton)
    }

    var mockSendPhoneVerificationCodeUseCase: Factory<SendPhoneVerificationCodeUseCase> {
        Factory(self) { MockSendPhoneVerificationCodeUseCase() }
            .scope(.singleton)
    }
}

extension Container {
    var mockLoginInteractor: Factory<LoginInteractor> {
        Factory(self) {
            DefaultLoginInteractor(
                appState: self.appState(),
                checkAccountLinkedSocialIdUseCase: self.mockCheckAccountLinkedSocialIdUseCase()
            )
        }
        .scope(.shared)
    }

    var stubTeacherHomeInteractor: Factory<TeacherHomeInteractor> {
        Factory(self) {
            DefaultTeacherHomeInteractor(
                serviceRepository: self.stubServiceRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase()
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
            DefaultServiceListInteractor(
                serviceRepository: self.stubServiceRepository(),
            )
        }
        .scope(.shared)
    }

    var stubChatInteractor: Factory<ChatInteractor> {
        Factory(self) {
            DefaultChatInteractor(
                appState: self.appState(),
                chatRepository: self.stubChatRepository(),
            )
        }
        .scope(.shared)
    }

    var stubServiceDetailInteractor: Factory<ServiceDetailInteractor> {
        Factory(self) {
            DefaultServiceDetailInteractor(
                appState: self.appState(),
                serviceRepository: self.stubServiceRepository(),
                chatRepository: self.stubChatRepository(),
            )
        }
        .scope(.shared)
    }

    var stubTeacherLessonManagementInteractor: Factory<TeacherLessonManagementInteractor> {
        Factory(self) {
            DefaultTeacherLessonManagementInteractor(
                appState: self.appState(),
                serviceRepository: self.stubServiceRepository(),
                chatRepository: self.stubChatRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase(),
            )
        }
        .scope(.shared)
    }

    var stubTeacherServiceManagementInteractor: Factory<TeacherServiceManagementInteractor> {
        Factory(self) {
            DefaultTeacherServiceManagementInteractor(
                appState: self.appState(),
                serviceRepository: self.stubServiceRepository(),
                chatRepository: self.stubChatRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase(),
            )
        }
        .scope(.shared)
    }

    var stubUmpaNotificationInteractor: Factory<UmpaNotificationInteractor> {
        Factory(self) {
            DefaultUmpaNotificationInteractor(
                umpaNotificationRepository: self.stubUmpaNotificationRepository(),
                getAccessTokenUseCase: self.getAccessTokenUseCase()
            )
        }
        .scope(.shared)
    }

    var mockPhoneVerificationInteractor: Factory<PhoneVerificationInteractor> {
        Factory(self) {
            DefaultPhoneVerificationInteractor(
                appState: self.appState(),
                sendPhoneVerificationCode: self.mockSendPhoneVerificationCodeUseCase()
            )
        }
        .scope(.shared)
    }
}

#endif
