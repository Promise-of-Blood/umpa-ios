// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol VerifyPhoneVerificationCodeUseCase {
    func callAsFunction(_ code: PhoneVerificationCode) -> AnyPublisher<Bool, Error>
}

public struct DefaultVerifyPhoneVerificationCodeUseCase {
    public init() {}
}

extension DefaultVerifyPhoneVerificationCodeUseCase: VerifyPhoneVerificationCodeUseCase {
    public func callAsFunction(_ code: PhoneVerificationCode) -> AnyPublisher<Bool, any Error> {
        fatalError()
    }
}
