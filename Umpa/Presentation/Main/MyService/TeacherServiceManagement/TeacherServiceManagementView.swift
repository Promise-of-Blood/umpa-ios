// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct TeacherServiceManagementView: View {
    @Injected(\.teacherServiceManagementInteractor) private var teacherServiceManagementInteractor

    @State private var serviceList: [any Service] = []

    var body: some View {
        content
            .onAppear {
                teacherServiceManagementInteractor.loadMyServiceList($serviceList)
            }
            .navigationDestination(for: ChatRoom.self) { chatRoom in
                ChatRoomView(chatRoom: chatRoom)
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
