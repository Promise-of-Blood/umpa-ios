// Created for Umpa in 2025

import Foundation

enum PhoneVerificationError: LocalizedError {
    case invalidPhoneNumber
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidPhoneNumber:
            "전화번호가 올바르지 않습니다."
        case .unknownError:
            "알 수 없는 오류가 발생했습니다."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidPhoneNumber:
            "전화번호를 확인해주세요."
        case .unknownError:
            "다시 시도해주세요."
        }
    }
}
