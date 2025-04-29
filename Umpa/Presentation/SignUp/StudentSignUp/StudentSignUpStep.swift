// Created for Umpa in 2025

import Foundation

enum StudentSignUpStep: Int, CaseIterable {
    case usernameInput = 0
    case majorSelection
    case dreamCollegeSelection
    case profileInput
    case preferSubjectSelection
    case lessonRequirement

    /// 현재 단계에 따라 0~1까지의 진행도를 나타내는 값
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

    /// 다음 단계로 넘어갑니다. 마지막 단계인 경우에는 마지막 단계를 유지합니다.
    mutating func next() {
        self = Self(rawValue: rawValue + 1) ?? .last
    }

    /// 이전 단계로 이동합니다. 첫 번째 단계인 경우에는 첫 번째 단계를 유지합니다.
    mutating func previous() {
        self = Self(rawValue: rawValue - 1) ?? .first
    }

    static let first = Self.usernameInput

    static let last = Self.lessonRequirement
}

extension StudentSignUpStep: Comparable {
    static func < (lhs: StudentSignUpStep, rhs: StudentSignUpStep) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension StudentSignUpStep: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .usernameInput:
            return "닉네임 입력"
        case .majorSelection:
            return "전공 선택"
        case .dreamCollegeSelection:
            return "희망 학교 선택"
        case .profileInput:
            return "프로필 입력"
        case .preferSubjectSelection:
            return "희망 과목 선택"
        case .lessonRequirement:
            return "수업 요구사항 입력"
        }
    }
}
