// Created for Umpa in 2025

import SwiftUI

public protocol MajorItem {
  var name: String { get }
  var imageResource: ImageResource { get }
}

public struct MajorSelectionButton<Item: MajorItem>: View {
  let major: Item
  let isSelected: Bool
  let action: () -> Void

  private let iconSize: CGFloat = fs(26)
  private let iconCornerRadius: CGFloat = fs(14)
  private let buttonSize: CGFloat = fs(52)

  public static func hidden() -> some View where Item == EmptyMajorItem {
    Self(major: EmptyMajorItem(), isSelected: false, action: {})
      .hidden()
  }

  public init(major: Item, isSelected: Bool, action: @escaping () -> Void) {
    self.major = major
    self.isSelected = isSelected
    self.action = action
  }

  // MARK: View

  public var body: some View {
    Button(action: action) {
      VStack(spacing: fs(4)) {
        Image(major.imageResource)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: iconSize, height: iconSize)
          .padding(fs(12))
          .background(isSelected ? UmpaColor.lightBlue : .white)
          .innerRoundedStroke(
            isSelected ? UmpaColor.mainBlue : UmpaColor.lightLightGray,
            cornerRadius: iconCornerRadius,
            lineWidth: fs(1.6)
          )
          .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))

        Text(major.name)
          .font(.pretendardMedium(size: fs(12)))
          .foregroundStyle(UmpaColor.darkGray)
          .lineLimit(1)
          .frame(maxWidth: .infinity, alignment: .center)
      }
      .frame(width: buttonSize)
    }
  }
}

public struct EmptyMajorItem: MajorItem {
  public let name: String = ""
  public let imageResource = ImageResource(name: "", bundle: .main)
}
