// Created for Umpa in 2025

import Factory
import SwiftUI

struct MyProfileView: View {
    @InjectedObject(\.appState) private var appState
    @Injected(\.myProfileInteractor) private var myProfileInteractor

    @Environment(\.dismiss) private var dismiss

    var body: some View {
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
