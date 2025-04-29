// Created for Umpa in 2025

import Foundation

enum StudentSignUpProgress: Int, CaseIterable {
    case usernameInput = 0
    case majorSelection
    case dreamCollegeSelection
    case profileInput
    case preferSubjectSelection
    case lessonRequirement

    var progressValue: CGFloat {
        let minProgress = 0.16
        let maxProgress = 0.9
        let steps = CGFloat(Self.allCases.count - 1)
        // rawValue 0 → minProgress, rawValue == steps → maxProgress
        return minProgress + (Double(rawValue) / steps) * (maxProgress - minProgress)
    }

    var isRequired: Bool {
        switch self {
        case .usernameInput,
             .majorSelection,
             .dreamCollegeSelection:
            return true
        case .profileInput,
             .preferSubjectSelection,
             .lessonRequirement:
            return false
        }
    }
}
