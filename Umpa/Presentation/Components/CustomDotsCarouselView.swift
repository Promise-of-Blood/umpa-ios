// Created for Umpa in 2025

import SwiftUI

struct CustomDotsCarouselView<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    
    @Binding private var selection: Int
    
    let pageCount: Int
    
    init(selection: Binding<Int>, pageCount: Int, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.pageCount = pageCount
        self.content = content
    }
    
    var body: some View {
        TabView(selection: $selection.animation()) {
            content()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            _PaginationDotsView(pageCount: pageCount, currentIndex: $selection)
                .offset(y: -20)
        }
    }
}

private struct _PaginationDotsView: View {
    let pageCount: Int
    @Binding var currentIndex: Int
  
    private let appearance: PaginationDotsViewAppearance
    
    init(
        pageCount: Int,
        currentIndex: Binding<Int>,
        appearance: PaginationDotsViewAppearance = DefaultPaginationDotsViewAppearance()
    ) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.appearance = appearance
    }
  
    var body: some View {
        HStack(spacing: appearance.circleSpacing) {
            ForEach(0 ..< pageCount, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? appearance.primaryColor : appearance.secondaryColor)
                    .scaleEffect(currentIndex == index ? 1 : appearance.smallScale)
                    .frame(width: appearance.circleSize, height: appearance.circleSize)
                    .transition(AnyTransition.opacity.combined(with: .scale))
            }
        }
    }
}

protocol PaginationDotsViewAppearance {
    var circleSize: CGFloat { get }
    var circleSpacing: CGFloat { get }
    
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    
    var smallScale: CGFloat { get }
}

struct DefaultPaginationDotsViewAppearance: PaginationDotsViewAppearance {
    let circleSize: CGFloat = 8
    let circleSpacing: CGFloat = 8
    
    let primaryColor = Color(hex: "#7D7D87")
    var secondaryColor = Color(hex: "#D9D9D9")
    
    let smallScale: CGFloat = 1.0
}

#Preview {
    @Previewable @State var index = 0
    let colors: [Color] = [.red, .blue, .yellow]
    CustomDotsCarouselView(selection: $index, pageCount: colors.count) {
        ForEach(0 ..< colors.count, id: \.self) { index in
            colors[index]
                .tag(index)
        }
    }
    .frame(width: 300, height: 200)
}
