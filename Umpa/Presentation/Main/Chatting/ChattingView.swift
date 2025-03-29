// Created for Umpa in 2025

import Factory
import SwiftUI

struct ChattingView: View {
    @Injected(\.chatInteractor) private var chatInteractor

    var body: some View {
        Text("Chatting")
    }
}

#Preview {
    ChattingView()
}
