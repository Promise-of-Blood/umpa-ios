// Created for Umpa in 2025

import SwiftUI

struct CarouselView<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content

    @Binding private var selection: Int

    init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.content = content
    }

    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

#Preview {
    @Previewable @State var index = 0
    CarouselView(selection: $index) {
        Color.red
            .tag(0)
        Color.blue
            .tag(1)
    }
}
