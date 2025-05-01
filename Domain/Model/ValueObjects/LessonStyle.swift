// Created for Umpa in 2025

import Foundation

public enum LessonStyle {
    case inPerson
    case remote
    case both

    public var name: String {
        switch self {
        case .inPerson:
            return "대면"
        case .remote:
            return "비대면"
        case .both:
            assertionFailure("현재 both에 해당하는 UI 요소는 없습니다.")
            return ""
        }
    }
}
