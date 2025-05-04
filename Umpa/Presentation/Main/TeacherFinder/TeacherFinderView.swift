// Created for Umpa in 2025

import Factory
import SwiftUI

struct TeacherFinderView: View {
    @InjectedObject(\.appState) private var appState

    var body: some View {
        content
    }

    var content: some View {
        ZStack {
            NavigationStack(path: $appState.routing.teacherFinderNavigationPath) {
                ServiceListView()
            }
            if !appState.userData.teacherFinder.isShowedServiceTypeSelectView {
                ServiceTypeSelectView()
                    .zIndex(1) // 전환 애니메이션이 제대로 보이도록 zIndex 설정
            }
        }
    }
}

#Preview {
    TabView {
        TeacherFinderView()
            .tabItem {
                Text("선생님 찾기")
            }
    }
}
