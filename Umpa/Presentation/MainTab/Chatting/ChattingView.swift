// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct ChattingView: View {
    @InjectedObject(\.appState) private var appState

    @Injected(\.chatInteractor) private var chatInteractor

    @State private var chattingRoomList: Loadable<[ChattingRoom], ChattingViewError>

    init(chattingRoomList: Loadable<[ChattingRoom], ChattingViewError> = .notRequested) {
        _chattingRoomList = .init(initialValue: chattingRoomList)
    }

    var body: some View {
        NavigationStack(path: $appState.routing.chattingNavigationPath) {
            content
                .navigationDestination(for: ChattingRoom.self) { chattingRoom in
                    ChattingRoomView(chattingRoom: chattingRoom)
                }
        }
        .errorAlert($chattingRoomList)
        .onAppear(perform: reloadChattingRoomList)
    }

    @ViewBuilder
    var content: some View {
        switch chattingRoomList {
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
            chattingRoomList = .failed(.fakeError)
        }
    }

    func loadedView(_ chattingRoomList: [ChattingRoom]) -> some View {
        IndexingForEach(chattingRoomList) { index, chattingRoom in
            NavigationLink(value: chattingRoomList[index]) {
                Text(chattingRoom.relatedService.author.name)
            }
        }
    }

    func reloadChattingRoomList() {
        chatInteractor.load(
            $chattingRoomList,
            for: appState.userData.currentUser!.id
        )
    }
}

enum ChattingViewError: LocalizedError {
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

#if MOCK

#Preview {
    @Injected(\.appState) var appState
    appState.userData.currentUser = Student.sample0

    return ChattingView()
}

#endif
