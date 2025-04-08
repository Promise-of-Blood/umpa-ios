// Created for Umpa in 2025

import Factory
import SwiftUI

struct ChattingView: View {
    @InjectedObject(\.appState) private var appState

    @Injected(\.chatInteractor) private var chatInteractor

    @State private var chattingRoomList: [ChattingRoom] = []

    var body: some View {
        content
            .onAppear {
                Task {
                    try await chatInteractor.load($chattingRoomList, for: appState.userData.currenteUser!.id)
                }
            }
    }

    var content: some View {
        NavigationStack(path: $appState.routing.chattingNavigationPath) {
            ForEach(chattingRoomList) { chattingRoom in
                NavigationLink(value: "") {
                    Text(chattingRoom.relatedService.author.name)
                }
                .navigationDestination(for: String.self) { _ in
                    ChattingRoomView(chattingRoom: .sample0)
                }
            }
        }
    }
}

#Preview {
    @Injected(\.appState) var appState
    appState.userData.currenteUser = Student.sample0

    return
        ChattingView()
}
