// Created for Umpa in 2025

import Factory
import SwiftUI

struct MyProfileView: View {
    @Injected(\.myProfileInteractor) private var myProfileInteractor
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            content
        }
    }

    @ViewBuilder
    var content: some View {
        Button(action: { dismiss() }) {
            Text("X")
        }
        Text("MyProfile")
        Button(action: {
            myProfileInteractor.logout()
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
