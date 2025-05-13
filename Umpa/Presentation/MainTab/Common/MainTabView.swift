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
      if appState.userData.loginInfo.isTeacher {
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
      "홈"
    case .teacherFinder:
      "선생님찾기"
    case .community:
      "커뮤니티"
    case .chat:
      "채팅"
    case .myProfile:
      "내정보"
    }
  }

  var imageResource: ImageResource {
    switch self {
    case .teacherHome:
      ImageResource(name: "home", bundle: .main)
    case .teacherFinder:
      ImageResource(name: "teacherFinder", bundle: .main)
    case .community:
      ImageResource(name: "community", bundle: .main)
    case .chat:
      ImageResource(name: "chat", bundle: .main)
    case .myProfile:
      ImageResource(name: "myProfile", bundle: .main)
    }
  }
}

#if DEBUG
#Preview {
  @Injected(\.appState) var appState
  appState.userData.loginInfo.currentUser = Student.sample0.eraseToAnyUser()

  return MainTabView()
}
#endif
