// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct ChatRoomView: View {
  @State private var chatRoom: ChatRoom

  init(chatRoom: ChatRoom) {
    self.chatRoom = chatRoom
  }

  var body: some View {
    content
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          DismissButton(.arrowBack)
        }
      }
  }

  @ViewBuilder
  var content: some View {
    VStack(spacing: 0) {
      // 채팅방 헤더
      HStack {
        VStack(alignment: .leading) {
          Text(chatRoom.relatedService.title)
            .font(.headline)
          HStack {
            Text("강사: \(chatRoom.relatedService.author.name)")
            Text("•")
            Text("학생: \(chatRoom.student.name)")
          }
          .font(.subheadline)
          .foregroundColor(.secondary)
        }
        Spacer()
      }
      .padding()
      .background(Color(.systemBackground))
      .shadow(color: Color.black.opacity(0.1), radius: 1)

      // 메시지 목록
      ScrollView {
        LazyVStack(spacing: 12) {
          ForEach(chatRoom.messages) { message in
            Text(message.text)
          }
        }
        .padding()
      }

      // 메시지 입력 영역
      HStack {
        TextField("메시지를 입력하세요", text: .constant(""))
          .padding(8)
          .background(Color(.systemGray6))
          .cornerRadius(20)

        Button(action: {
          // 메시지 전송 로직
        }) {
          Image(systemName: "paperplane.fill")
            .foregroundColor(.blue)
        }
      }
      .padding()
    }
  }
}

#if DEBUG
#Preview {
  ChatRoomView(chatRoom: .sample0)
}
#endif
