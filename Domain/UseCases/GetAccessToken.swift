// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol GetAccessTokenUseCase {
    func callAsFunction() -> AnyPublisher<AccessToken?, Error>
}

public struct DefaultGetAccessTokenUseCase {
    private let jwtRepository: JwtRepository

    public init(jwtRepository: JwtRepository) {
        self.jwtRepository = jwtRepository
    }
}

extension DefaultGetAccessTokenUseCase: GetAccessTokenUseCase {
    public func callAsFunction() -> AnyPublisher<AccessToken?, Error> {
        jwtRepository.getAccessToken()
    }
}
