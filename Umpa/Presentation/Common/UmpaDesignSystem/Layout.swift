// Created for Umpa in 2025

import Foundation

/// 피그마 디자인에서 사용하는 값을 실제 UI와 맞추기 위해 적절한 스케일을 적용한 값을 반환합니다.
@inlinable public func fs(_ value: CGFloat) -> CGFloat {
    let scale: CGFloat = 1.075
    return value * scale
}
