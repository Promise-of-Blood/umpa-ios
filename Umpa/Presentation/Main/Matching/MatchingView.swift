// Created for Umpa in 2025

import Factory
import SwiftUI

struct MatchingView: View {
    @InjectedObject(\.appState) private var appState

    var body: some View {
        NavigationStack(path: $appState.routing.teacherFindingNavigationPath) {
            content
        }
    }

    var content: some View {
        ServiceListView()
    }
}

#Preview {
    MatchingView()
}
