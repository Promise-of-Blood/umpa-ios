// Created for Umpa in 2025

import SwiftUI

extension View {
    @inlinable public func innerRoundedStroke<S>(
        _ shapeStyle: S,
        cornerRadius: CGFloat,
        lineWidth: CGFloat = 1
    ) -> some View where S: ShapeStyle {
        overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(shapeStyle, lineWidth: lineWidth)
        }
    }

    public func innerStroke<S>(
        _ shapeStyle: S,
        edges: Edge.Set = .all,
        lineWidth: CGFloat = 1
    ) -> some View where S: ShapeStyle {
        overlay { EdgeStroke(lineWidth: lineWidth, edges: edges) }
            .foregroundStyle(shapeStyle)
    }
}

private struct EdgeStroke: Shape {
    let lineWidth: CGFloat
    let edges: Edge.Set

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topPath = Path(CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: lineWidth))
        let bottomPath = Path(CGRect(x: rect.minX, y: rect.maxY - lineWidth, width: rect.width, height: lineWidth))
        let leadingPath = Path(CGRect(x: rect.minX, y: rect.minY, width: lineWidth, height: rect.height))
        let tailingPath = Path(CGRect(x: rect.maxX - lineWidth, y: rect.minY, width: lineWidth, height: rect.height))

        if edges.contains(.top) {
            path.addPath(topPath)
        }
        if edges.contains(.bottom) {
            path.addPath(bottomPath)
        }
        if edges.contains(.leading) {
            path.addPath(leadingPath)
        }
        if edges.contains(.trailing) {
            path.addPath(tailingPath)
        }
        if edges.contains(.horizontal) {
            path.addPath(leadingPath)
            path.addPath(tailingPath)
        }
        if edges.contains(.vertical) {
            path.addPath(topPath)
            path.addPath(bottomPath)
        }
        if edges.contains(.all) {
            path.addPath(topPath)
            path.addPath(bottomPath)
            path.addPath(leadingPath)
            path.addPath(tailingPath)
        }

        return path
    }
}
