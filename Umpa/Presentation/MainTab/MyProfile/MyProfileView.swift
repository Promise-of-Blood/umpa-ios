// Created for Umpa in 2025

import Factory
import SwiftUI

struct MyProfileView: View {
  @Environment(\.appState) private var appState
  @Environment(\.dismiss) private var dismiss

  @Injected(\.myProfileInteractor) private var myProfileInteractor

  var body: some View {
    @Bindable var appState = appState
    NavigationStack(path: $appState.routing.myProfileNavigationPath) {
      content
        .navigationDestination(for: String.self) { _ in
          TestView()
        }
    }
  }

  @ViewBuilder
  var content: some View {
    Button(action: { dismiss() }) {
      Text("X")
    }
    Text("MyProfile")

    NavigationLink(value: "Test") {
      Text("이동")
    }

    List {
      Rectangle()
        .listRowSeparator(.hidden)
      Rectangle()
        .listRowSeparator(.hidden)
      Rectangle()
        .listRowSeparator(.hidden)
      Rectangle()
        .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
}

struct TestView: View {
  @Injected(\.myProfileInteractor) private var myProfileInteractor
  var body: some View {
    Button(action: {
      myProfileInteractor.logout()
    }) {
      Text("로그아웃")
    }
  }
}

#Preview {
  MyProfileView()
}
