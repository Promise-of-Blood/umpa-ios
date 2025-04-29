// Created for Umpa in 2025

import Foundation

enum TeacherSignUpProgress: Int, CaseIterable {
    case majorSelection = 0
    case profileInput
    case experienceInput
    case linkInput

    var progressValue: Double {
        let minProgress = 0.2
        let maxProgress = 0.85
        let steps = Double(Self.allCases.count - 1)
        // rawValue 0 → minProgress, rawValue == steps → maxProgress
        return minProgress + (Double(rawValue) / steps) * (maxProgress - minProgress)
    }
}
