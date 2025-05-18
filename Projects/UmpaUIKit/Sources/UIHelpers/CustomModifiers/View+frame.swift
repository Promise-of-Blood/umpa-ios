// Created for Umpa in 2025

import SwiftUI

extension View {
    /// 수평 방향으로는 최대 너비까지 유연하게, 수직 방향으로는 지정된 높이로 고정되는 프레임을 설정합니다.
    public func frame(maxWidth: CGFloat, height: CGFloat, alignment: Alignment = .center) -> some View {
        return frame(maxWidth: maxWidth, idealHeight: height, alignment: alignment)
            .fixedSize(horizontal: false, vertical: true)
    }

    /// 수직 방향으로는 최대 높이까지 유연하게, 수평 방향으로는 지정된 너비로 고정되는 프레임을 설정합니다.
    public func frame(width: CGFloat, maxHeight: CGFloat, alignment: Alignment = .center) -> some View {
        return frame(idealWidth: width, maxHeight: maxHeight, alignment: alignment)
            .fixedSize(horizontal: true, vertical: false)
    }
}
