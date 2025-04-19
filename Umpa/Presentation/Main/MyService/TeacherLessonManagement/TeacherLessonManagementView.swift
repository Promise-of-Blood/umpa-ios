// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct TeacherLessonManagementView: View {
    @Injected(\.stubTeacherLessonManagementInteractor) private var teacherLessonManagementInteractor

    @State private var lessonList: [LessonService] = []

    var body: some View {
        content
            .onAppear {
                teacherLessonManagementInteractor.loadMyLessonList($lessonList)
            }
            .navigationDestination(for: ChatRoom.self) { chatRoom in
                ChatRoomView(chatRoom: chatRoom)
            }
    }

    var content: some View {
        ForEach(lessonList, id: \.id) { lesson in
            Text(lesson.title)
        }
    }
}

#Preview {
    TeacherLessonManagementView()
}
