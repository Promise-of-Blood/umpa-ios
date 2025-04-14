// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

struct ChatRoomView: View {
    @State private var chatRoom: ChatRoom

    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
    }

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    @ViewBuilder
    var content: some View {
        Text(chatRoom.relatedService.author.name)
        Text(chatRoom.student.name)
        ForEach(chatRoom.messages) { message in
            Text(message.text)
        }
    }
}

#if MOCK
#Preview {
    ChatRoomView(chattingRoom: .sample0)
}
#endif
