// Created for Umpa in 2025

import Factory
import SwiftUI
import Utility

protocol ChatInteractor {
    @MainActor
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws

    func startChatting(with service: any Service)

    func enterChattingRoom(with id: ChattingRoom.Id) async throws
}

struct DefaultChatInteractor: ChatInteractor {
    @Injected(\.appState) private var appState

    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws {
        fatalError()
    }

    /// 주어진 `service`에 대해 채팅을 시작합니다.
    ///
    /// 이미 만들어진 채팅방이 있을 경우 해당 채팅방으로 이동합니다.
    func startChatting(with service: any Service) {
        guard let student = appState.userData.currenteUser as? Student else { return }

        let chattingRoom = ChattingRoom(
            id: nil,
            student: student,
            relatedService: service.toAnyService(),
            messages: []
        )

        // TODO: 채팅방이 이미 존재하는지 확인하고, 존재한다면 해당 채팅방으로 이동하는 로직 추가 필요

        appState.routing.currentTab = .chatting
        appState.routing.chattingNavigationPath.removeAll()
        appState.routing.chattingNavigationPath.append(chattingRoom)
    }

    func enterChattingRoom(with id: ChattingRoom.Id) async throws {
        fatalError()
    }
}

#if MOCK
struct MockChatInteractor: ChatInteractor {
    @Injected(\.appState) private var appState
    let realInteractor = DefaultChatInteractor()

    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws {
        chats.wrappedValue = [
            .sample0,
        ]
    }

    func startChatting(with service: any Service) {
        realInteractor.startChatting(with: service)
    }

    func enterChattingRoom(with id: ChattingRoom.Id) async throws {
        fatalError()
    }
}
#endif
