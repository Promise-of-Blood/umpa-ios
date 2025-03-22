// Created for Umpa in 2025

import Combine
import SwiftUI
import Utility

struct MainView: View {
    private var cancelBag = CancelBag()

    @EnvironmentObject var appState: AppState

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
        }
        .onAppear {
            bindingAppState()
        }
    }

    private func bindingAppState() {
        appState.$currentTabIndex
            .sink { index in
                selection = index
            }
            .store(in: cancelBag)
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
