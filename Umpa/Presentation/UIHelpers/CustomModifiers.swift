// Created for Umpa in 2025

import SwiftUI

extension View {
    @inlinable func innerStroke<S>(
        _ shapeStyle: S,
        cornerRadius: CGFloat,
        lineWidth: CGFloat = 1
    ) -> some View where S: ShapeStyle {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(shapeStyle, lineWidth: lineWidth)
        )
    }
}
