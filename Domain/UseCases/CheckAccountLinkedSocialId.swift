// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol CheckAccountLinkedSocialIdUseCase {
    func callAsFunction(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error>
}

public struct DefaultCheckAccountLinkedSocialIdUseCase {
    private let serverRepository: ServerRepository

    public init(serverRepository: ServerRepository) {
        self.serverRepository = serverRepository
    }
}

extension DefaultCheckAccountLinkedSocialIdUseCase: CheckAccountLinkedSocialIdUseCase {
    public func callAsFunction(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error> {
        fatalError("Not implemented")
    }
}
