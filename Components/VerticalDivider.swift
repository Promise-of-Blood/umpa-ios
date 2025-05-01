// Created for Umpa in 2025

import SwiftUI

public struct VerticalDivider: View {
    let thickness: CGFloat
    let color: Color

    public init(thickness: CGFloat = 1, color: Color) {
        self.thickness = thickness
        self.color = color
    }

    public var body: some View {
        Rectangle()
            .frame(idealWidth: thickness, maxHeight: .infinity)
            .fixedSize(horizontal: true, vertical: false)
            .foregroundStyle(color)
    }
}

#Preview {
    VerticalDivider(color: .gray)
        .padding()

    VerticalDivider(thickness: 2, color: .black)
        .padding()

    VerticalDivider(thickness: 10, color: .blue)
        .padding()

    VerticalDivider(thickness: 0, color: .red)
        .padding()
    
    HStack(spacing: 0) {
        Color.blue
        VerticalDivider(color: .red)
        Color.blue
        VerticalDivider(color: .red)
        Color.blue
        VerticalDivider(color: .red)
        Color.blue
    }
    .frame(width: 300, height: 80)
}
