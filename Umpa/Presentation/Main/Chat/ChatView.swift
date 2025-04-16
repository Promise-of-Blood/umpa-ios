// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct ChatView: View {
    @InjectedObject(\.appState) private var appState

    @Injected(\.chatInteractor) private var chatInteractor

    @State private var chatRoomList: Loadable<[ChatRoom], ChatInteractorError>

    init(chatRoomList: Loadable<[ChatRoom], ChatInteractorError> = .notRequested) {
        _chatRoomList = .init(initialValue: chatRoomList)
    }

    var body: some View {
        NavigationStack(path: $appState.routing.chatNavigationPath) {
            content
                .navigationDestination(for: ChatRoom.self) { chatRoom in
                    ChatRoomView(chatRoom: chatRoom)
                }
        }
        .errorAlert($chatRoomList)
        .onAppear(perform: reloadChatRoomList)
    }

    @ViewBuilder
    var content: some View {
        switch chatRoomList {
        case .notRequested:
            Text("")
                .onAppear(perform: reloadChatRoomList)
        case .isLoading:
            ProgressView()
        case .loaded(let chatRoomList):
            loadedView(chatRoomList)
        case .failed:
            loadedView([])
        }

        Button("에러 발생") {
            chatRoomList = .failed(.fakeError)
        }
    }

    func loadedView(_ chatRoomList: [ChatRoom]) -> some View {
        IndexingForEach(chatRoomList) { index, chatRoom in
            NavigationLink(value: chatRoomList[index]) {
                Text(chatRoom.relatedService.author.name)
            }
        }
    }

    func reloadChatRoomList() {
        chatInteractor.load($chatRoomList)
    }
}

#if DEBUG

#Preview {
    @Injected(\.appState) var appState
    appState.userData.login.currentUser = Student.sample0

    return ChatView()
}

#endif
