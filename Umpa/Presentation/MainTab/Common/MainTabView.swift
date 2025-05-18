// Created for Umpa in 2025

import AppSettingFeature
import BaseFeature
import Domain
import SwiftUI

struct MainTabView: View {
  @Environment(AppState.self) private var appState

  var body: some View {
    content
  }

  @ViewBuilder
  var content: some View {
    @Bindable var appState = appState
    TabView(selection: $appState.routing.currentTab) {
      switch appState.userData.loginInfo.userType {
      case .student:
        studentEntry
      case .teacher:
        teacherEntry
      case .none:
        EmptyView()
      }
    }
  }

  @ViewBuilder
  var studentEntry: some View {
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

  @ViewBuilder
  var teacherEntry: some View {
    TeacherHomeView()
      .tabItem {
        MainTabView.TabLabel(category: .teacherHome)
      }
      .tag(MainViewTabType.teacherHome)
//    ProfileServiceManagementView()
    ChatView()
      .tabItem {
        MainTabView.TabLabel(category: .chat)
      }
      .tag(MainViewTabType.chat)
    AppSettingsView()
      .tabItem {
        MainTabView.TabLabel(category: .appSettings)
      }
      .tag(MainViewTabType.appSettings)
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
    case .appSettings:
      "설정"
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
    case .appSettings:
      ImageResource(name: "appSettings", bundle: .main)
    }
  }
}

#if DEBUG
#Preview {
  @Previewable @Environment(AppState.self) var appState
  appState.userData.loginInfo.currentUser = Student.sample0.eraseToAnyUser()

  return MainTabView()
}
#endif
