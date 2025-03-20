// Created for Umpa in 2025

import SwiftUI
import Utility

public protocol Pagination: View {
    var currentIndex: Binding<Int> { get }
    var pageCount: Int { get }
}

public struct DotsPagination: View, Pagination {
    public var currentIndex: Binding<Int>
    
    public let pageCount: Int
  
    public let appearance: DotsPaginationAppearance
    
    public init(
        currentIndex: Binding<Int>,
        pageCount: Int,
        appearance: DotsPaginationAppearance? = nil
    ) {
        self.currentIndex = currentIndex
        self.pageCount = pageCount
        self.appearance = appearance ?? DotsPaginationAppearance.default
    }
  
    public var body: some View {
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

public struct DotsPaginationAppearance {
    /// The size of each dot.
    public let size: CGFloat
    
    /// The spacing between each dot.
    public let spacing: CGFloat
    
    /// The color of a dot when it is not selected.
    public let normalColor: Color
    
    /// The color of a dot when it is selected.
    public let selectedColor: Color
    
    /// The scale factor for a dot when it is selected.
    public let selectedScale: CGFloat
    
    public init(
        size: CGFloat,
        spacing: CGFloat,
        normalColor: Color,
        selectedColor: Color,
        selectedScale: CGFloat
    ) {
        self.size = size
        self.spacing = spacing
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.selectedScale = selectedScale
    }
    
    static let `default` = DotsPaginationAppearance(
        size: 8,
        spacing: 8,
        normalColor: Color(hex: "9C9C9C"),
        selectedColor: Color(hex: "72727C"),
        selectedScale: 1.0
    )
}

#Preview {
    @Previewable @State var index = 2
    let colors: [Color] = [.red, .blue, .yellow]
    
    DotsPagination(
        currentIndex: $index,
        pageCount: colors.count,
        appearance: DotsPaginationAppearance.default
    )
}
