// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation
import Mockable
import SwiftUI

@MainActor
protocol PhoneVerificationInteractor {
    func requestVerificationCode(
        with phoneNumber: String,
        isSentVerificationCode: ValueLoadableBinding<Bool>,
        expirationTime: Binding<Date>,
        isExpired: Binding<Bool>,
        e: Binding<PhoneVerificationError?>
    )
    func resendVerificationCode(
        with phoneNumber: String,
        verificationCode: Binding<String>,
        expirationTime: Binding<Date>,
        isExpired: Binding<Bool>,
        e: Binding<PhoneVerificationError?>
    )
    func verifyCodeToNext(_ code: String, isVerifiedCode: ValueLoadableBinding<Bool?>)
}

struct DefaultPhoneVerificationInteractor {
    private let appState: AppState

    private let sendPhoneVerificationCode: SendPhoneVerificationCodeUseCase
    private let verifyPhoneVerificationCode: VerifyPhoneVerificationCodeUseCase

    private let cancelBag = CancelBag()

    /// 인증 코드 유효 시간
    private let codeExpirationTime: Int = 180

    public init(
        appState: AppState,
        sendPhoneVerificationCode: SendPhoneVerificationCodeUseCase,
        verifyPhoneVerificationCode: VerifyPhoneVerificationCodeUseCase,
    ) {
        self.appState = appState
        self.sendPhoneVerificationCode = sendPhoneVerificationCode
        self.verifyPhoneVerificationCode = verifyPhoneVerificationCode

        #if DEBUG
        setupMockBehavior()
        #endif
    }

    #if DEBUG
    private func setupMockBehavior() {
        if let mockSendPhoneVerificationCodeUseCase =
            sendPhoneVerificationCode as? MockSendPhoneVerificationCodeUseCase
        {
            given(mockSendPhoneVerificationCodeUseCase)
                .callAsFunction(to: .any)
                .willReturn(
                    Just(())
                        .delay(for: 1, scheduler: DispatchQueue.global())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
        }
        if let mockVerifyPhoneVerificationCodeUseCase =
            verifyPhoneVerificationCode as? MockVerifyPhoneVerificationCodeUseCase
        {
            given(mockVerifyPhoneVerificationCodeUseCase)
                .callAsFunction(.any)
                .willProduce { code in
                    // 999999 일 때만 false를 반환
                    Just(code.rawCode != "999999")
                        .delay(for: 1, scheduler: DispatchQueue.global())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
        }
    }
    #endif
}

extension DefaultPhoneVerificationInteractor: PhoneVerificationInteractor {
    func requestVerificationCode(
        with phoneNumber: String,
        isSentVerificationCode: ValueLoadableBinding<Bool>,
        expirationTime: Binding<Date>,
        isExpired: Binding<Bool>,
        e: Binding<PhoneVerificationError?>
    ) {
        guard let phoneNumber = PhoneNumber(phoneNumber: phoneNumber) else {
            e.wrappedValue = .invalidPhoneNumber
            return
        }

        let cancelBag = CancelBag()

        isSentVerificationCode.wrappedValue.setIsLoading(cancelBag: cancelBag)

        sendPhoneVerificationCode(to: phoneNumber)
            .sink { completion in
                if completion.isError {
                    e.wrappedValue = .unknownError
                }
            } receiveValue: { _ in
                isSentVerificationCode.wrappedValue = .value(true)
                expirationTime.wrappedValue = Date.now.addingTimeInterval(TimeInterval(codeExpirationTime))
                isExpired.wrappedValue = false
            }
            .store(in: cancelBag)
    }

    func resendVerificationCode(
        with phoneNumber: String,
        verificationCode: Binding<String>,
        expirationTime: Binding<Date>,
        isExpired: Binding<Bool>,
        e: Binding<PhoneVerificationError?>
    ) {
        guard let phoneNumber = PhoneNumber(phoneNumber: phoneNumber) else {
            e.wrappedValue = .invalidPhoneNumber
            return
        }

        verificationCode.wrappedValue = ""

        // 일정 시간 재전송을 방지하는 로직이 추가될 수 있음

        sendPhoneVerificationCode(to: phoneNumber)
            .sink { completion in
                if completion.isError {
                    e.wrappedValue = .unknownError
                }
            } receiveValue: { _ in
                expirationTime.wrappedValue = Date.now.addingTimeInterval(TimeInterval(codeExpirationTime))
                isExpired.wrappedValue = false
            }
            .store(in: cancelBag)
    }

    func verifyCodeToNext(_ code: String, isVerifiedCode: ValueLoadableBinding<Bool?>) {
        guard let verificationCode = PhoneVerificationCode(rawCode: code) else {
            isVerifiedCode.wrappedValue = .value(false)
            return
        }

        let cancelBag = CancelBag()

        isVerifiedCode.wrappedValue.setIsLoading(cancelBag: cancelBag)

        verifyPhoneVerificationCode(verificationCode)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if completion.isError {
                    isVerifiedCode.wrappedValue = .value(false)
                }
            } receiveValue: { isVerified in
                isVerifiedCode.wrappedValue = .value(isVerified)
                if isVerified {
                    UmpaLogger.log("전화번호 인증 성공(\(code)), 약관 동의 화면으로 이동", level: .debug)
                    appState.routing.loginNavigationPath.append(SignUpRoute.acceptTerms)
                }
            }
            .store(in: cancelBag)
    }
}
