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
            HomeView()
                .tabItem {
                    MainTabView.TabLabel(category: .home)
                }
                .tag(MainViewTabType.home)
            MatchingView()
                .tabItem {
                    MainTabView.TabLabel(category: .matching)
                }
                .tag(MainViewTabType.matching)
            CommunityView()
                .tabItem {
                    MainTabView.TabLabel(category: .community)
                }
                .tag(MainViewTabType.community)
            ChattingView()
                .tabItem {
                    MainTabView.TabLabel(category: .chatting)
                }
                .tag(MainViewTabType.chatting)
        }
    }
}

enum TabCategory {
    case home
    case matching
    case community
    case chatting

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .matching:
            return "매칭서비스"
        case .community:
            return "커뮤니티"
        case .chatting:
            return "채팅"
        }
    }

    // TODO: 실제 리소스로 변경
    var imageResource: ImageResource {
        switch self {
        case .home:
            return ImageResource(name: "home", bundle: .main)
        case .matching:
            return ImageResource(name: "matching", bundle: .main)
        case .community:
            return ImageResource(name: "community", bundle: .main)
        case .chatting:
            return ImageResource(name: "chatting", bundle: .main)
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

#Preview {
    @Injected(\.appState) var appState
    appState.userData.currenteUser = Student.sample0

    return
        MainTabView()
}
