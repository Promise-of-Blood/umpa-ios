// Created for Umpa in 2025

import SwiftUI

public struct HorizontalDivider: View {
  let thickness: CGFloat
  let color: Color?

  public init(thickness: CGFloat = 1, color: Color? = nil) {
    self.thickness = thickness
    self.color = color
  }

  public var body: some View {
    let divider = Rectangle()
      .frame(maxWidth: .infinity, idealHeight: thickness)
      .fixedSize(horizontal: false, vertical: true)
    return Group {
      if let color {
        divider
          .foregroundStyle(color)
      } else {
        divider
      }
    }
  }
}

#Preview {
  HorizontalDivider(color: .gray)
    .padding()

  HorizontalDivider(thickness: 2, color: .black)
    .padding()

  HorizontalDivider(thickness: 10, color: .blue)
    .padding()

  HorizontalDivider(thickness: 0, color: .red)
    .padding()
}
