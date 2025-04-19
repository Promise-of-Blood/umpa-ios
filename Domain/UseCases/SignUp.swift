// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol SignUpUseCase {
    func callAsFunction() -> AnyPublisher<AnyUser, Error>
}

public struct DefaultSignUpUseCase {
    private let serverRepository: ServerRepository
    private let jwtRepository: JwtRepository

    public init(serverRepository: ServerRepository, jwtRepository: JwtRepository) {
        self.serverRepository = serverRepository
        self.jwtRepository = jwtRepository
    }
}

extension DefaultSignUpUseCase: SignUpUseCase {
    public func callAsFunction() -> AnyPublisher<AnyUser, Error> {
        fatalError("Not implemented")
    }
}
