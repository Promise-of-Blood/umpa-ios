// Created for Umpa in 2025

import SwiftUI

public struct HorizontalDivider: View {
    let thickness: CGFloat
    let color: Color

    public init(thickness: CGFloat = 1, color: Color) {
        self.thickness = thickness
        self.color = color
    }

    public var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, idealHeight: thickness)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(color)
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
