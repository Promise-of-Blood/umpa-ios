// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol SendPhoneVerificationCodeUseCase {
    func callAsFunction() -> AnyPublisher<Void, Error>
}

public struct DefaultSendPhoneVerificationCodeUseCase {
    public init() {}
}

extension DefaultSendPhoneVerificationCodeUseCase: SendPhoneVerificationCodeUseCase {
    public func callAsFunction() -> AnyPublisher<Void, Error> {
        fatalError()
    }
}
