// Created for Umpa in 2025

import SwiftUI

private struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

extension View {
    public func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        modifier(FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}
