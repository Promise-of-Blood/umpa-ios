// Created for Umpa in 2025

import Combine
import Domain
import Factory
import SwiftUI
import Utility

protocol ChatInteractor {
    /// 채팅방 목록을 로드합니다.
    func load(_ chattingRoomList: Binding<Loadable<[ChattingRoom], ChattingViewError>>, for id: User.Id)

    /// 주어진 `service`에 대해 채팅을 시작합니다.
    ///
    /// 이미 만들어진 채팅방이 있을 경우 해당 채팅방으로 이동합니다.
    func startChatting(with service: any Service, navigationPath: Binding<NavigationPath>)

    /// 채팅 목록 화면에서 주어진 `id`의 채팅방으로 이동합니다.
    func enterChattingRoom(with id: ChattingRoom.Id)
}

struct DefaultChatInteractor: ChatInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()

    func load(_ chattingRoomList: Binding<Loadable<[ChattingRoom], ChattingViewError>>, for id: User.Id) {
        chattingRoomList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        serverRepository.fetchChattingRoomList()
            .mapError { _ in
                ChattingViewError.fakeError
            }
            .sinkToLoadable(chattingRoomList)
            .store(in: cancelBag)
    }

    func startChatting(with service: any Service, navigationPath: Binding<NavigationPath>) {
        guard let student = appState.userData.currentUser as? Student else { return }

        serverRepository.fetchChattingRoom(for: service.id)
            .replaceNil(with: ChattingRoom(
                id: nil,
                student: student,
                relatedService: service.toAnyService(),
                messages: []
            ))
            .sink { completion in
                if let error = completion.error {
                    // TODO: error 처리
                }
            } receiveValue: { chattingRoom in
                navigationPath.wrappedValue.append(chattingRoom)
            }
            .store(in: cancelBag)
    }

    func enterChattingRoom(with id: ChattingRoom.Id) {
        serverRepository.fetchChattingRoom(by: id)
            .sink { completion in
                if let error = completion.error {
                    // TODO: error 처리
                }
            } receiveValue: { chattingRoom in
                appState.routing.chattingNavigationPath.append(chattingRoom)
            }
            .store(in: cancelBag)
    }
}
