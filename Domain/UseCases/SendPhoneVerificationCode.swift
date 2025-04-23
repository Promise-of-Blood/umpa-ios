// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol SendPhoneVerificationCodeUseCase {
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
