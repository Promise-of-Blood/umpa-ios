// Created for Umpa in 2025

import Combine
import Domain
import Factory
import SwiftUI
import Utility

protocol ChatInteractor {
    /// 채팅방 목록을 로드합니다.
    func load(_ chatRoomList: Binding<Loadable<[ChatRoom], ChatInteractorError>>, for id: User.Id)

    /// 주어진 `service`에 대해 채팅을 시작합니다.
    ///
    /// 이미 만들어진 채팅방이 있을 경우 해당 채팅방으로 이동합니다.
    func startChat(with service: any Service, navigationPath: Binding<NavigationPath>)

    /// 채팅 목록 화면에서 주어진 `id`의 채팅방으로 이동합니다.
    func enterChatRoom(with id: ChatRoom.Id)
}

struct ChatInteractorImpl: ChatInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()

    func load(_ chatRoomList: Binding<Loadable<[ChatRoom], ChatInteractorError>>, for id: User.Id) {
        chatRoomList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        serverRepository.fetchChatRoomList()
            .mapError { _ in
                ChatInteractorError.fakeError
            }
            .sinkToLoadable(chatRoomList)
            .store(in: cancelBag)
    }

    func startChat(with service: any Service, navigationPath: Binding<NavigationPath>) {
        guard let student = appState.userData.currentUser as? Student else { return }

        serverRepository.fetchChatRoom(for: service.id)
            .replaceNil(with: ChatRoom(
                id: nil,
                student: student,
                relatedService: service.toAnyService(),
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

    func enterChatRoom(with id: ChatRoom.Id) {
        serverRepository.fetchChatRoom(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: error 처리
                }
            } receiveValue: { chatRoom in
                appState.routing.chatNavigationPath.append(chatRoom)
            }
            .store(in: cancelBag)
    }
}

enum ChatInteractorError: LocalizedError {
    case fakeError

    var errorDescription: String? {
        switch self {
        case .fakeError:
            return "Fake Error errorDescription"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .fakeError:
            return "Fake Error recoverySuggestion"
        }
    }
}
