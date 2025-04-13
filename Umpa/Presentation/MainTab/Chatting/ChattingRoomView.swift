// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

struct ChattingRoomView: View {
    @State private var chattingRoom: ChattingRoom

    init(chattingRoom: ChattingRoom) {
        self.chattingRoom = chattingRoom
    }

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    @ViewBuilder
    var content: some View {
        Text(chattingRoom.relatedService.author.name)
        Text(chattingRoom.student.name)
        ForEach(chattingRoom.messages) { message in
            Text(message.text)
        }
    }
}

#Preview {
    #if MOCK
        ChattingRoomView(chattingRoom: .sample0)
    #endif
}
