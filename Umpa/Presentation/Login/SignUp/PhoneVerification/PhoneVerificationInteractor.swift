// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation
import Mockable

@MainActor
protocol PhoneVerificationInteractor {
    func requestVerification(with phoneNumber: PhoneNumber)
    func resendVerificationCode()
    func verifyCodeToNext(_ code: String)
}

struct DefaultPhoneVerificationInteractor {
    private let appState: AppState

    private let sendPhoneVerificationCode: SendPhoneVerificationCodeUseCase

    private let cancelBag = CancelBag()

    public init(appState: AppState, sendPhoneVerificationCode: SendPhoneVerificationCodeUseCase) {
        self.appState = appState
        self.sendPhoneVerificationCode = sendPhoneVerificationCode

        #if DEBUG
        if let mockSendPhoneVerificationCode = sendPhoneVerificationCode as? MockSendPhoneVerificationCodeUseCase {
            given(mockSendPhoneVerificationCode)
        }
        #endif
    }
}

extension DefaultPhoneVerificationInteractor: PhoneVerificationInteractor {
    func resendVerificationCode() {
        fatalError()
    }

    func requestVerification(with phoneNumber: PhoneNumber) {
        fatalError()
    }

    func verifyCodeToNext(_ code: String) {
        fatalError()
    }
}
