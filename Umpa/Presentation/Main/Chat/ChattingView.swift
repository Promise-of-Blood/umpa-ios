// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct ChattingView: View {
    @InjectedObject(\.appState) private var appState

    @Injected(\.chatInteractor) private var chatInteractor

    @State private var chatRoomList: Loadable<[ChatRoom], ChatInteractorError>

    init(chatRoomList: Loadable<[ChatRoom], ChatInteractorError> = .notRequested) {
        _chatRoomList = .init(initialValue: chatRoomList)
    }

    var body: some View {
        NavigationStack(path: $appState.routing.chatNavigationPath) {
            content
                .navigationDestination(for: ChatRoom.self) { chattingRoom in
                    ChatRoomView(chatRoom: chattingRoom)
                }
        }
        .errorAlert($chatRoomList)
        .onAppear(perform: reloadChattingRoomList)
    }

    @ViewBuilder
    var content: some View {
        switch chatRoomList {
        case .notRequested:
            Text("")
                .onAppear(perform: reloadChattingRoomList)
        case .isLoading:
            ProgressView()
        case .loaded(let chattingRoomList):
            loadedView(chattingRoomList)
        case .failed:
            loadedView([])
        }

        Button("에러 발생") {
            chatRoomList = .failed(.fakeError)
        }
    }

    func loadedView(_ chattingRoomList: [ChatRoom]) -> some View {
        IndexingForEach(chattingRoomList) { index, chattingRoom in
            NavigationLink(value: chattingRoomList[index]) {
                Text(chattingRoom.relatedService.author.name)
            }
        }
    }

    func reloadChattingRoomList() {
        chatInteractor.load(
            $chatRoomList,
            for: appState.userData.currentUser!.id
        )
    }
}

#if MOCK

#Preview {
    @Injected(\.appState) var appState
    appState.userData.currentUser = Student.sample0

    return ChattingView()
}

#endif
