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
            if let userType = try? appState.userData.login.userType,
               userType == .teacher
            {
                TeacherHomeView()
                    .tabItem {
                        MainTabView.TabLabel(category: .teacherHome)
                    }
                    .tag(MainViewTabType.teacherHome)
            }
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
            MyProfileView()
                .tabItem {
                    MainTabView.TabLabel(category: .myProfile)
                }
                .tag(MainViewTabType.myProfile)
        }
    }
}

extension MainTabView {
    struct TabLabel: View {
        let category: MainViewTabType

        var body: some View {
            VStack {
                Image(category.imageResource)
                Text(category.title)
            }
        }
    }
}

extension MainViewTabType {
    var title: String {
        switch self {
        case .teacherHome:
            return "홈"
        case .teacherFinder:
            return "선생님찾기"
        case .community:
            return "커뮤니티"
        case .chat:
            return "채팅"
        case .myProfile:
            return "내정보"
        }
    }

    var imageResource: ImageResource {
        switch self {
        case .teacherHome:
            return ImageResource(name: "home", bundle: .main)
        case .teacherFinder:
            return ImageResource(name: "teacherFinder", bundle: .main)
        case .community:
            return ImageResource(name: "community", bundle: .main)
        case .chat:
            return ImageResource(name: "chat", bundle: .main)
        case .myProfile:
            return ImageResource(name: "myProfile", bundle: .main)
        }
    }
}

#if MOCK
#Preview {
    @Injected(\.appState) var appState
    appState.userData.login.currentUser = Student.sample0

    return
        MainTabView()
}
#endif
