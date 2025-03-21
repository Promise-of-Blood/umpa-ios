// Created for Umpa in 2025

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    TabLabel(category: .home)
                }
                .tag(0)
            MatchingView()
                .tabItem {
                    TabLabel(category: .matching)
                }
                .tag(1)
            CommunityView()
                .tabItem {
                    TabLabel(category: .community)
                }
                .tag(2)
            ChattingView()
                .tabItem {
                    TabLabel(category: .chatting)
                }
                .tag(3)
            MyProfileView()
                .tabItem {
                    TabLabel(category: .myProfile)
                }
                .tag(4)
        }
    }
}

enum TabCategory {
    case home
    case matching
    case community
    case chatting
    case myProfile

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
        case .myProfile:
            return "내 정보"
        }
    }

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
        case .myProfile:
            return ImageResource(name: "myProfile", bundle: .main)
        }
    }
}

struct TabLabel: View {
    let category: TabCategory

    var body: some View {
        VStack {
            Image(category.imageResource)
            Text(category.title)
        }
    }
}

#Preview {
    MainView()
}
