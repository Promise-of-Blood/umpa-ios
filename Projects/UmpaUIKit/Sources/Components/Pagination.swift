// Created for Umpa in 2025

import SwiftUI

public protocol Pagination: View {
  var currentIndex: Binding<Int> { get set }
  var pageCount: Int { get }
}

public struct DotsPagination: View, Pagination {
  public var currentIndex: Binding<Int>

  public let pageCount: Int

  public let appearance: Appearance

  public init(
    currentIndex: Binding<Int>,
    pageCount: Int,
    appearance: Appearance = .fromDefault()
  ) {
    self.currentIndex = currentIndex
    self.pageCount = pageCount
    self.appearance = appearance
  }

  public var body: some View {
    HStack(spacing: appearance.spacing) {
      ForEach(0 ..< pageCount, id: \.self) { index in
        Circle()
          .fill(currentIndex.wrappedValue == index ? appearance.highlightColor : appearance.normalColor)
          .scaleEffect(currentIndex.wrappedValue == index ? appearance.highlightScale : 1)
          .frame(width: appearance.size, height: appearance.size)
          .transition(AnyTransition.opacity.combined(with: .scale))
      }
    }
  }
}

extension DotsPagination {
  public struct Appearance {
    /// The size of each dot.
    public let size: CGFloat

    /// The spacing between each dot.
    public let spacing: CGFloat

    /// The color of a dot when it is not highlighted.
    public let normalColor: Color

    /// The color of a dot when it is highlighted.
    public let highlightColor: Color

    /// The scale factor for a dot when it is highlighted.
    public let highlightScale: CGFloat

    public init(
      size: CGFloat,
      spacing: CGFloat,
      normalColor: Color,
      highlightColor: Color,
      highlightScale: CGFloat,
    ) {
      self.size = size
      self.spacing = spacing
      self.normalColor = normalColor
      self.highlightColor = highlightColor
      self.highlightScale = highlightScale
    }

    public static func fromDefault(
      size: CGFloat = 8,
      spacing: CGFloat = 8,
      normalColor: Color = Color(red: 0x9C / 255, green: 0x9C / 255, blue: 0x9C / 255),
      highlightColor: Color = Color(red: 0x72 / 255, green: 0x72 / 255, blue: 0x7C / 255),
      highlightScale: CGFloat = 1.2,
    ) -> Appearance {
      Appearance(
        size: size,
        spacing: spacing,
        normalColor: normalColor,
        highlightColor: highlightColor,
        highlightScale: highlightScale
      )
    }
  }
}

#Preview {
  @Previewable @State var index = 2
  let colors: [Color] = [.red, .blue, .yellow]

  DotsPagination(
    currentIndex: $index,
    pageCount: colors.count,
    appearance: .fromDefault()
  )
}
