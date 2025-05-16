// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation
import Mockable
import SwiftUI
import UmpaUIKit

@MainActor
protocol PhoneVerificationInteractor {
  /// `phoneNumber`로 인증번호를 발송합니다.
  func sendVerificationCode(
    with phoneNumber: String,
    isSentVerificationCode: ValueLoadableBinding<Bool>,
    expirationTime: Binding<Date>,
    isExpired: Binding<Bool>,
    e: Binding<PhoneVerificationError?>
  )

  /// 인증번호를 발송하고 다음 화면으로 이동합니다.
  func sendVerificationCodeAndMoveToNext(with phoneNumber: String, e: Binding<PhoneVerificationError?>)

  /// `phoneNumber`로 인증번호를 재발송합니다.
  func resendVerificationCode(
    with phoneNumber: String,
    verificationCode: Binding<String>,
    expirationTime: Binding<Date>,
    isExpired: Binding<Bool>,
    isResendingVerificationCode: Binding<Bool>,
    isVerifiedCode: ValueLoadableBinding<Bool?>,
    e: Binding<PhoneVerificationError?>
  )

  // 인증번호를 검증하고 다음 화면으로 이동합니다. 인증번호가 틀릴 경우 이동하지 않습니다.
  func verifyCodeAndMoveToNext(_ verificationCode: String, isVerifiedCode: ValueLoadableBinding<Bool?>)
}

struct DefaultPhoneVerificationInteractor {
  private let appState: AppState

  private let sendPhoneVerificationCode: SendPhoneVerificationCodeUseCase
  private let verifyPhoneVerificationCode: VerifyPhoneVerificationCodeUseCase

  private let cancelBag = CancelBag()

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
        .willProduce { phoneNumber in
          if phoneNumber.rawNumber == "01099999999" {
            Fail(error: PhoneVerificationError.failedSendingVerificationCode)
              .delay(for: 1, scheduler: DispatchQueue.global())
              .eraseToAnyPublisher()
          } else {
            Just(())
              .delay(for: 1, scheduler: DispatchQueue.global())
              .setFailureType(to: Error.self)
              .eraseToAnyPublisher()
          }
        }
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
  func sendVerificationCodeAndMoveToNext(
    with phoneNumber: String,
    e: Binding<PhoneVerificationError?>,
  ) {
    guard let phoneNumber = PhoneNumber(phoneNumber: phoneNumber) else {
      e.wrappedValue = .invalidPhoneNumber
      return
    }

#if DEBUG
    UmpaLogger(category: .signUp).log("인증번호 발송 -> \(phoneNumber.rawNumber)", level: .debug)
#endif

    appState.routing.loginNavigationPath.append(PhoneVerificationView.NavigationDestination.verificationCodeInput)

    sendPhoneVerificationCode(to: phoneNumber)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if completion.isError {
          e.wrappedValue = .failedSendingVerificationCode
        }
      } receiveValue: { _ in }
      .store(in: cancelBag)
  }

  func sendVerificationCode(
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
        expirationTime.wrappedValue = Date.now.addingTimeInterval(TimeInterval(SignUpConstant.verificationCodeExpirationTime))
        isExpired.wrappedValue = false
      }
      .store(in: cancelBag)
  }

  func resendVerificationCode(
    with phoneNumber: String,
    verificationCode: Binding<String>,
    expirationTime: Binding<Date>,
    isExpired: Binding<Bool>,
    isResendingVerificationCode: Binding<Bool>,
    isVerifiedCode: ValueLoadableBinding<Bool?>,
    e: Binding<PhoneVerificationError?>
  ) {
    guard let phoneNumber = PhoneNumber(phoneNumber: phoneNumber) else {
      e.wrappedValue = .invalidPhoneNumber
      return
    }

    verificationCode.wrappedValue = ""
    isResendingVerificationCode.wrappedValue = true
    isVerifiedCode.wrappedValue.value = nil

    // 일정 시간 재전송을 방지하는 로직이 추가될 수 있음

    sendPhoneVerificationCode(to: phoneNumber)
      .sink { completion in
        isResendingVerificationCode.wrappedValue = false
        if completion.isError {
          e.wrappedValue = .failedResendingVerificationCode
        }
      } receiveValue: { _ in
        expirationTime.wrappedValue = Date.now.addingTimeInterval(TimeInterval(SignUpConstant.verificationCodeExpirationTime))
        isExpired.wrappedValue = false
      }
      .store(in: cancelBag)
  }

  func verifyCodeAndMoveToNext(_ verificationCode: String, isVerifiedCode: ValueLoadableBinding<Bool?>) {
    guard let verificationCode = PhoneVerificationCode(rawCode: verificationCode) else {
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
          UmpaLogger.log("전화번호 인증 성공(\(verificationCode)), 약관 동의 화면으로 이동", level: .debug)
          appState.routing.loginNavigationPath.append(VerificationCodeInputView.NavigationDestination.acceptTerms)
        }
      }
      .store(in: cancelBag)
  }
}
