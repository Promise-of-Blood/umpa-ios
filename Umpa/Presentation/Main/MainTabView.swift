// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct MainTabView: View {
    @InjectedObject(\.appState) private var appState

    var body: some View {
        content
    }

    var content: some View {
        TabView(selection: $appState.routing.currentTab) {
            TeacherHomeView()
                .tabItem {
                    MainTabView.TabLabel(category: .home)
                }
                .tag(MainViewTabType.home)
            TeacherFinderView()
                .tabItem {
                    MainTabView.TabLabel(category: .teacherFinder)
                }
                .tag(MainViewTabType.teacherFinder)
            ChatView()
                .tabItem {
                    MainTabView.TabLabel(category: .chat)
                }
                .tag(MainViewTabType.chat)
        }
    }
}

enum TabCategory {
    case home
    case teacherFinder
    case community
    case chat

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .teacherFinder:
            return "매칭서비스"
        case .community:
            return "커뮤니티"
        case .chat:
            return "채팅"
        }
    }

    // TODO: 실제 리소스로 변경
    var imageResource: ImageResource {
        switch self {
        case .home:
            return ImageResource(name: "home", bundle: .main)
        case .teacherFinder:
            return ImageResource(name: "matching", bundle: .main)
        case .community:
            return ImageResource(name: "community", bundle: .main)
        case .chat:
            return ImageResource(name: "chat", bundle: .main)
        }
    }
}

extension MainTabView {
    struct TabLabel: View {
        let category: TabCategory

        var body: some View {
            VStack {
                Image(category.imageResource)
                Text(category.title)
            }
        }
    }
}

#if MOCK
#Preview {
    @Injected(\.appState) var appState
    appState.userData.currentUser = Student.sample0

    return
        MainTabView()
}
#endif
