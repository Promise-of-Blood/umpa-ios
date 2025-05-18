// Created for Umpa in 2025

import SwiftUI

public struct Carousel<Content>: View where Content: View {
  @Binding private var currentIndex: Int

  @ViewBuilder let content: () -> Content

  public init(currentIndex: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
    _currentIndex = currentIndex
    self.content = content
  }

  public var body: some View {
    TabView(selection: $currentIndex) {
      content()
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
}

#Preview(traits: .fixedLayout(width: 400, height: 400)) {
  @Previewable @State var index = 0
  Carousel(currentIndex: $index) {
    Color.red
      .frame(width: 200, height: 200)
      .tag(0)
    Color.blue
      .tag(1)
  }
  .frame(width: 300, height: 300)
  .background(Color.gray)
}
