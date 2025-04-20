// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

protocol ServiceDetailInteractor {
    func markAsLike(_ isLiked: Bool, for id: Service.Id)
    func load(_ lesson: Binding<LessonService>, by id: LessonService.Id)
    func load(_ accompanistService: Binding<AccompanistService>, by id: Service.Id)
    func load(_ scoreCreationService: Binding<ScoreCreationService>, by id: Service.Id)
    func load(_ musicCreationService: Binding<MusicCreationService>, by id: Service.Id)

    /// 주어진 `service`에 대해 채팅을 시작합니다.
    ///
    /// 이미 만들어진 채팅방이 있을 경우 해당 채팅방으로 이동합니다.
    func startChat(with service: AnyService, navigationPath: Binding<NavigationPath>)
}

struct DefaultServiceDetailInteractor {
    private let appState: AppState

    private let serviceRepository: ServiceRepository
    private let chatRepository: ChatRepository

    private let cancelBag = CancelBag()

    init(appState: AppState, serviceRepository: ServiceRepository, chatRepository: ChatRepository) {
        self.appState = appState
        self.serviceRepository = serviceRepository
        self.chatRepository = chatRepository
    }
}

extension DefaultServiceDetailInteractor: ServiceDetailInteractor {
    func startChat(with service: AnyService, navigationPath: Binding<NavigationPath>) {
        guard let student = appState.userData.login.currentUser?.unwrap(as: Student.self) else { return }

        chatRepository.fetchChatRoom(for: service.id)
            .replaceNil(with: ChatRoom(
                id: nil,
                student: student,
                relatedService: service,
                messages: []
            ))
            .sink { completion in
                if let error = completion.error {
                    // TODO: error 처리
                }
            } receiveValue: { chatRoom in
                navigationPath.wrappedValue.append(chatRoom)
            }
            .store(in: cancelBag)
    }

    func markAsLike(_ isLiked: Bool, for id: Service.Id) {
        serviceRepository.updateLikeStatus(isLiked, for: id)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .replaceError(with: ())
            .sink { _ in }
            .store(in: cancelBag)
    }

    func load(_ lesson: Binding<LessonService>, by id: LessonService.Id) {
        serviceRepository.fetchLessonDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                lesson.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ accompanistService: Binding<Domain.AccompanistService>, by id: Service.Id) {
        serviceRepository.fetchAccompanistServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                accompanistService.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ scoreCreationService: Binding<Domain.ScoreCreationService>, by id: Service.Id) {
        serviceRepository.fetchScoreCreationServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                scoreCreationService.wrappedValue = value
            }
            .store(in: cancelBag)
    }

    func load(_ musicCreationService: Binding<Domain.MusicCreationService>, by id: Service.Id) {
        serviceRepository.fetchMusicCreationServiceDetail(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { value in
                musicCreationService.wrappedValue = value
            }
            .store(in: cancelBag)
    }
}
