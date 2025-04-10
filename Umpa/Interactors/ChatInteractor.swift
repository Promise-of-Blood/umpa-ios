// Created for Umpa in 2025

import Combine
import Domain
import Factory
import SwiftUI
import Utility

protocol ChatInteractor {
    func load(_ chattingRoomList: Binding<Loadable<[ChattingRoom], ChattingViewError>>, for id: User.Id)
    func startChatting(with service: any Service)
    func enterChattingRoom(with id: ChattingRoom.Id)
}

struct DefaultChatInteractor: ChatInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository

    func load(_ chattingRoomList: Binding<Loadable<[ChattingRoom], ChattingViewError>>, for id: User.Id) {
        let cancelBag = CancelBag()
        chattingRoomList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        serverRepository.fetchChattingRoomList()
            .mapError { _ in
                ChattingViewError.fakeError
            }
            .sinkToLoadable(chattingRoomList)
            .store(in: cancelBag)
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

    func enterChattingRoom(with id: ChattingRoom.Id) {
        fatalError()
    }
}
