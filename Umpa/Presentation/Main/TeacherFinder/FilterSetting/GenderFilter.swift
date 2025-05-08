// Created for Umpa in 2025

import Foundation

enum GenderFilter {
    case all
    case female
    case male

    var name: String {
        switch self {
        case .all:
            return "전체"
        case .female:
            return "여자"
        case .male:
            return "남자"
        }
    }
}
