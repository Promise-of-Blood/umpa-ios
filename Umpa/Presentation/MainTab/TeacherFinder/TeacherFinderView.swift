// Created for Umpa in 2025

import BaseFeature
import Factory
import SwiftUI

struct TeacherFinderView: View {
  @Environment(AppState.self) private var appState

  var body: some View {
    content
  }

  var content: some View {
    ZStack {
      if appState.userData.teacherFinder.hasDisplayedServiceTypeSelectOnBoarding {
        ServiceListView()
      } else {
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
        VStack {
          Image(systemName: "star")
          Text("선생님 찾기")
        }
      }
  }
}
