// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol SetAccessTokenUseCase {
    func callAsFunction(_ token: AccessToken) -> AnyPublisher<Void, Error>
}

public struct DefaultSetAccessTokenUseCase {
    private let jwtRepository: JwtRepository

    public init(jwtRepository: JwtRepository) {
        self.jwtRepository = jwtRepository
    }
}

extension DefaultSetAccessTokenUseCase: SetAccessTokenUseCase {
    public func callAsFunction(_ token: AccessToken) -> AnyPublisher<Void, Error> {
        jwtRepository.setAccessToken(token)
    }
}
