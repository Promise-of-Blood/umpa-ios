// Created for Umpa in 2025

import SwiftUI

extension View {
    @inlinable func innerStroke<S>(_ shapeStyle: S, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(shapeStyle, lineWidth: 1)
        )
    }
}
