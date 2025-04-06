// Created for Umpa in 2025

import Factory
import SwiftUI

class MainViewSharedData: ObservableObject {
    @Published var currentTabIndex: Int = 0
    @Published var selectedService: ServiceType = .lesson
    @Published var selectedSubjectInTeacherFinding: Subject?
}

struct MainTabView: View {
    @InjectedObject(\.mainViewSharedData) private var mainViewSharedData

    var body: some View {
        content
    }

    var content: some View {
        TabView(selection: $mainViewSharedData.currentTabIndex) {
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
    MainTabView()
}
