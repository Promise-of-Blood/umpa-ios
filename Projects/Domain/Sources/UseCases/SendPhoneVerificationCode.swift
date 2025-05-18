// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol SendPhoneVerificationCodeUseCase {
    /// 지정된 전화번호로 인증 코드를 전송합니다.
    func callAsFunction(to phoneNumber: PhoneNumber) -> AnyPublisher<Void, Error>
}

public struct DefaultSendPhoneVerificationCodeUseCase {
    public init() {}
}

extension DefaultSendPhoneVerificationCodeUseCase: SendPhoneVerificationCodeUseCase {
    public func callAsFunction(to phoneNumber: PhoneNumber) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}
