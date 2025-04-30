// Created for Umpa in 2025

import Foundation

enum TeacherSignUpStep: Int, CaseIterable {
    case majorSelection = 0
    case profileInput
    case experienceInput
    case linkInput

    var canSkip: Bool {
        switch self {
        case .majorSelection, .profileInput, .experienceInput:
            return false
        case .linkInput:
            return true
        }
    }

    /// 현재 단계에 따라 0~1까지의 진행도를 나타내는 값
    var progressValue: Double {
        let minProgress = 0.2
        let maxProgress = 0.85
        let steps = Double(Self.allCases.count - 1)
        // rawValue 0 → minProgress, rawValue == steps → maxProgress
        return minProgress + (Double(rawValue) / steps) * (maxProgress - minProgress)
    }

    /// 다음 단계로 넘어갑니다. 마지막 단계인 경우에는 마지막 단계를 유지합니다.
    mutating func next() {
        self = Self(rawValue: rawValue + 1) ?? .last
    }

    /// 이전 단계로 이동합니다. 첫 번째 단계인 경우에는 첫 번째 단계를 유지합니다.
    mutating func previous() {
        self = Self(rawValue: rawValue - 1) ?? .first
    }

    static let first = Self.majorSelection

    static let last = Self.linkInput
}

extension TeacherSignUpStep: Comparable {
    static func < (lhs: TeacherSignUpStep, rhs: TeacherSignUpStep) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension TeacherSignUpStep: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .majorSelection:
            return "전공 선택"
        case .profileInput:
            return "프로필 입력"
        case .experienceInput:
            return "경력 입력"
        case .linkInput:
            return "사이트 링크 입력"
        }
    }
}
