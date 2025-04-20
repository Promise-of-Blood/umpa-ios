// Created for Umpa in 2025

import DataAccess
import Domain
import Factory

// MARK: - Mock

#if DEBUG

extension Container {
    // MARK: - Repository

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

    // MARK: - UseCase

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
}

#endif
