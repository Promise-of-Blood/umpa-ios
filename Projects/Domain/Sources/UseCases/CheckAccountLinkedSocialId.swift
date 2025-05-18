// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol CheckAccountLinkedSocialIdUseCase {
    func callAsFunction(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error>
}

public struct DefaultCheckAccountLinkedSocialIdUseCase {
    private let jwtRepository: JwtRepository

    public init(jwtRepository: JwtRepository) {
        self.jwtRepository = jwtRepository
    }
}

extension DefaultCheckAccountLinkedSocialIdUseCase: CheckAccountLinkedSocialIdUseCase {
    public func callAsFunction(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error> {
        fatalError("Not implemented")
    }
}
