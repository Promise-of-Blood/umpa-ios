// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

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

struct ServiceDetailInteractorImpl {
    let appState: AppState
    let serverRepository: ServerRepository

    let cancelBag = CancelBag()
}

extension ServiceDetailInteractorImpl: ServiceDetailInteractor {
    func startChat(with service: AnyService, navigationPath: Binding<NavigationPath>) {
        guard let student = appState.userData.login.currentUser?.unwrap(as: Student.self) else { return }

        serverRepository.fetchChatRoom(for: service.id)
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
        serverRepository.updateLikeStatus(isLiked, for: id)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .replaceError(with: ())
            .sink { _ in }
            .store(in: cancelBag)
    }

    func load(_ lesson: Binding<LessonService>, by id: LessonService.Id) {
        serverRepository.fetchLessonDetail(by: id)
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
        serverRepository.fetchAccompanistServiceDetail(by: id)
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
        serverRepository.fetchScoreCreationServiceDetail(by: id)
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
        serverRepository.fetchMusicCreationServiceDetail(by: id)
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
