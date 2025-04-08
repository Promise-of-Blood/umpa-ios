// Created for Umpa in 2025

import Factory
import SwiftUI

struct MyProfileView: View {
    @Injected(\.appState) private var appState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: { dismiss() }) {
            Text("X")
        }
        Text("MyProfile")
        Button(action: {
            appState.userData.currenteUser = nil
        }) {
            Text("로그아웃")
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

#Preview {
    MyProfileView()
}
