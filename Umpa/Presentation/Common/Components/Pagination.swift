// Created for Umpa in 2025

import SwiftUI

protocol Pagination: View {
    var currentIndex: Binding<Int> { get }
    var pageCount: Int { get }
}

struct DotsPagination: View, Pagination {
    var currentIndex: Binding<Int>
    
    let pageCount: Int
  
    let appearance: DotsPaginationAppearance
    
    init(
        currentIndex: Binding<Int>,
        pageCount: Int,
        appearance: DotsPaginationAppearance? = nil
    ) {
        self.currentIndex = currentIndex
        self.pageCount = pageCount
        self.appearance = appearance ?? DotsPaginationAppearance.builtIn
    }
  
    var body: some View {
        HStack(spacing: appearance.spacing) {
            ForEach(0 ..< pageCount, id: \.self) { index in
                Circle()
                    .fill(currentIndex.wrappedValue == index ? appearance.selectedColor : appearance.normalColor)
                    .scaleEffect(currentIndex.wrappedValue == index ? appearance.selectedScale : 1)
                    .frame(width: appearance.size, height: appearance.size)
                    .transition(AnyTransition.opacity.combined(with: .scale))
            }
        }
    }
}

struct DotsPaginationAppearance {
    /// The size of each dot.
    let size: CGFloat
    
    /// The spacing between each dot.
    let spacing: CGFloat
    
    /// The color of a dot when it is not selected.
    let normalColor: Color
    
    /// The color of a dot when it is selected.
    let selectedColor: Color
    
    /// The scale factor for a dot when it is selected.
    let selectedScale: CGFloat
    
    static let builtIn = DotsPaginationAppearance(
        size: 8,
        spacing: 8,
        normalColor: UmpaColor.lightGray,
        selectedColor: UmpaColor.darkGray,
        selectedScale: 1.0
    )
}

#Preview {
    @Previewable @State var index = 2
    let colors: [Color] = [.red, .blue, .yellow]
    
    DotsPagination(
        currentIndex: $index,
        pageCount: colors.count,
        appearance: DotsPaginationAppearance.builtIn
    )
}
