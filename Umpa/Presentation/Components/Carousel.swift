// Created for Umpa in 2025

import SwiftUI

struct Carousel<Content>: View where Content: View {
    @Binding private var selection: Int

    @ViewBuilder let content: () -> Content

    init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.content = content
    }

    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    @Previewable @State var index = 0
    Carousel(selection: $index) {
        Color.red
            .tag(0)
        Color.blue
            .tag(1)
    }
}
