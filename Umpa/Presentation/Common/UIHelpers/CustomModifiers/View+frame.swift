// Created for Umpa in 2025

import SwiftUI

extension View {
    public func frame(maxWidth: CGFloat, height: CGFloat) -> some View {
        return frame(maxWidth: maxWidth, idealHeight: height)
            .fixedSize(horizontal: false, vertical: true)
    }

    public func frame(width: CGFloat, maxHeight: CGFloat) -> some View {
        return frame(idealWidth: width, maxHeight: maxHeight)
            .fixedSize(horizontal: true, vertical: false)
    }
}
