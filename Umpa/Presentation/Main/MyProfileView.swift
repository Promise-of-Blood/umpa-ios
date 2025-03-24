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
            appState.isLoggedIn = false
        }) {
            Text("로그아웃")
        }
    }
}

#Preview {
    MyProfileView()
}
