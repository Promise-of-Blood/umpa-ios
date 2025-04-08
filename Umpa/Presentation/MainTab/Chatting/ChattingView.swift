// Created for Umpa in 2025

import Factory
import SwiftUI

struct ChattingView: View {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.appState) private var appState
    @InjectedObject(\.mainViewRouter) private var mainViewRouter

    @State private var chattingRoomList: [ChattingRoom] = []

    var body: some View {
        content
            .onAppear {
                Task {
                    try await chatInteractor.load($chattingRoomList, for: appState.currenteUser!.id)
                }
            }
    }

    var content: some View {
        NavigationStack(path: $mainViewRouter.chattingNavigationPath) {
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
    appState.currenteUser = Student.sample0

    return
        ChattingView()
}
