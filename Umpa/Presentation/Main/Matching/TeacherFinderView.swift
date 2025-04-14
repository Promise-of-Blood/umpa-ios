// Created for Umpa in 2025

import Factory
import SwiftUI

struct TeacherFinderView: View {
    @InjectedObject(\.appState) private var appState

    var body: some View {
        NavigationStack(path: $appState.routing.teacherFinderNavigationPath) {
            content
        }
    }

    var content: some View {
        ServiceListView()
    }
}

#Preview {
    TeacherFinderView()
}
