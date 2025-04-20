// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import SwiftUI

@MainActor
protocol ChatInteractor {
    /// 채팅방 목록을 로드합니다.
    func load(_ chatRoomList: Binding<Loadable<[ChatRoom], ChatInteractorError>>)

    /// 채팅 목록 화면에서 주어진 `id`의 채팅방으로 이동합니다.
    func enterChatRoom(with id: ChatRoom.Id)
}

struct DefaultChatInteractor {
    private let appState: AppState

    private let serverRepository: ServerRepository

    private let cancelBag = CancelBag()

    init(appState: AppState, serverRepository: ServerRepository) {
        self.appState = appState
        self.serverRepository = serverRepository
    }
}

extension DefaultChatInteractor: ChatInteractor {
    func load(_ chatRoomList: Binding<Loadable<[ChatRoom], ChatInteractorError>>) {
        chatRoomList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        serverRepository.fetchChatRoomList()
            .mapError { _ in
                ChatInteractorError.fakeError
            }
            .sinkToLoadable(chatRoomList)
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
