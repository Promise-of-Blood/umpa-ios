// Created for Umpa in 2025

import Foundation

/// 전공
public enum Major: Hashable, CaseIterable {
    case piano
    case vocal
    case drum
    case guitar
    case bass

    /// 전자음악
    case electronicMusic
    case composition

    /// 관악
    case windInstrument

    public var name: String {
        switch self {
        case .piano:
            return "피아노"
        case .vocal:
            return "보컬"
        case .drum:
            return "드럼"
        case .guitar:
            return "기타"
        case .bass:
            return "베이스"
        case .electronicMusic:
            return "전자음악"
        case .composition:
            return "작곡"
        case .windInstrument:
            return "관악"
        }
    }
}
