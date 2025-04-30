// Created for Umpa in 2025

import DataAccess
import Domain
import Factory

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

    private var collegeRepository: Factory<CollegeRepository> {
        Factory(self) {
            DefaultCollegeRepository(
                network: self.network()
            )
        }
        .scope(.singleton)
    }

    private var majorRepository: Factory<MajorRepository> {
        Factory(self) {
            DefaultMajorRepository()
        }
        .scope(.singleton)
    }

    private var regionRepository: Factory<RegionRepository> {
        Factory(self) {
            DefaultRegionRepository(
                network: self.network()
            )
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
    private var studentSignUpUseCase: Factory<StudentSignUpUseCase> {
        Factory(self) {
            DefaultStudentSignUpUseCase(
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

    private var verifyPhoneVerificationCodeUseCase: Factory<VerifyPhoneVerificationCodeUseCase> {
        Factory(self) {
            DefaultVerifyPhoneVerificationCodeUseCase()
        }
        .scope(.singleton)
    }
}

// MARK: - Interactor

extension Container {
    var appInteractor: Factory<AppInteractor> {
        Factory(self) {
            DefaultAppInteractor(
                appState: self.appState(),
                collegeRepository: self.collegeRepository(),
                majorRepository: self.majorRepository(),
                regionRepository: self.regionRepository()
            )
        }
        .scope(.singleton)
    }

    var phoneVerificationInteractor: Factory<PhoneVerificationInteractor> {
        Factory(self) {
            DefaultPhoneVerificationInteractor(
                appState: self.appState(),
                sendPhoneVerificationCode: self.sendPhoneVerificationCodeUseCase(),
                verifyPhoneVerificationCode: self.verifyPhoneVerificationCodeUseCase()
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

    var acceptTermsInteractor: Factory<AcceptTermsInteractor> {
        Factory(self) {
            DefaultAcceptTermsInteractor(
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

    var mockCollegeRepository: Factory<CollegeRepository> {
        Factory(self) {
            MockCollegeRepository()
        }
        .scope(.singleton)
    }

    var mockMajorRepository: Factory<MajorRepository> {
        Factory(self) {
            MockMajorRepository()
        }
        .scope(.singleton)
    }

    var stubRegionRepository: Factory<RegionRepository> {
        Factory(self) {
            StubRegionRepository()
        }
        .scope(.singleton)
    }
}

// MARK: - UseCase

extension Container {
    var mockStudentSignUpUseCase: Factory<StudentSignUpUseCase> {
        Factory(self) { MockStudentSignUpUseCase() }
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

    var mockVerifyPhoneVerificationCodeUseCase: Factory<VerifyPhoneVerificationCodeUseCase> {
        Factory(self) { MockVerifyPhoneVerificationCodeUseCase() }
            .scope(.singleton)
    }

    var mockCheckAvailableUsernameUseCase: Factory<CheckAvailableUsernameUseCase> {
        Factory(self) { MockCheckAvailableUsernameUseCase() }
            .scope(.singleton)
    }
}

// MARK: - Interactor

extension Container {
    var mockAppInteractor: Factory<AppInteractor> {
        Factory(self) {
            DefaultAppInteractor(
                appState: self.appState(),
                collegeRepository: self.mockCollegeRepository(),
                majorRepository: self.mockMajorRepository(),
                regionRepository: self.stubRegionRepository(),
            )
        }
        .scope(.shared)
    }

    var mockStudentSignUpInteractor: Factory<StudentSignUpInteractor> {
        Factory(self) {
            DefaultStudentSignUpInteractor(
                appState: self.appState(),
                signUp: self.mockStudentSignUpUseCase(),
                checkAvailableUsername: self.mockCheckAvailableUsernameUseCase()
            )
        }
        .scope(.shared)
    }

    var mockTeacherSignUpInteractor: Factory<TeacherSignUpInteractor> {
        Factory(self) {
            DefaultTeacherSignUpInteractor()
        }
        .scope(.shared)
    }

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
                sendPhoneVerificationCode: self.mockSendPhoneVerificationCodeUseCase(),
                verifyPhoneVerificationCode: self.mockVerifyPhoneVerificationCodeUseCase()
            )
        }
        .scope(.shared)
    }
}

#endif
