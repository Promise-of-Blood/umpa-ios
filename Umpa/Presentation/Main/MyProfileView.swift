// Created for Umpa in 2025

import SwiftUI

struct MyProfileView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: { dismiss() }) {
            Text("X")
        }
        Text("MyProfile")
    }
}

#Preview {
    MyProfileView()
}
