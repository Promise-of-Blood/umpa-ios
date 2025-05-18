// Created for Umpa in 2025

import Foundation

enum PhoneVerificationError: LocalizedError {
    case invalidPhoneNumber
    case unknownError
    case failedSendingVerificationCode
    case failedResendingVerificationCode

    var errorDescription: String? {
        switch self {
        case .invalidPhoneNumber:
            "전화번호가 올바르지 않습니다"
        case .unknownError:
            "알 수 없는 오류가 발생했습니다"
        case .failedSendingVerificationCode:
            "인증번호 발송에 실패했습니다"
        case .failedResendingVerificationCode:
            "인증번호 재발송에 실패했습니다"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidPhoneNumber:
            "전화번호를 확인해주세요"
        case .unknownError:
            "다시 시도해주세요"
        case .failedSendingVerificationCode:
            "인증번호를 다시 요청해주세요"
        case .failedResendingVerificationCode:
            "인증번호를 다시 요청해주세요"
        }
    }
}
