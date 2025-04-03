// Created for Umpa in 2025

import Foundation

enum PriceUnitType {
    case hour
    case sheet
    case song
    case school

    var text: String {
        switch self {
        case .hour:
            return "시간"
        case .sheet:
            return "장"
        case .song:
            return "곡"
        case .school:
            return "학교"
        }
    }
}
