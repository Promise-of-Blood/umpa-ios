// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct TeacherServiceManagementView: View {
  @Injected(\.teacherServiceManagementInteractor) var interactor

  @State private var serviceList: [AnyService] = []

  var body: some View {
    content
      .onAppear {
        interactor?.loadMyServiceList($serviceList)
      }
      .navigationDestination(for: ChatRoom.self) { chatRoom in
//        ChatRoomView(chatRoom: chatRoom)
      }
  }

  var content: some View {
    ForEach(serviceList, id: \.id) { service in
      Text(service.title)
    }
  }
}

#Preview {
  TeacherServiceManagementView()
}

extension Container {
  public var teacherServiceManagementInteractor: Factory<TeacherServiceManagementInteractor?> {
    self { nil }
  }
}
