// Created for Umpa in 2025

import Foundation

enum ServiceType: CaseIterable {
    case lesson
    case accompanist
    case scoreCreation
    case mrCreation

    var name: String {
        switch self {
        case .lesson:
            return "레슨"
        case .accompanist:
            return "반주자"
        case .scoreCreation:
            return "악보제작"
        case .mrCreation:
            return "MR제작"
        }
    }
}
