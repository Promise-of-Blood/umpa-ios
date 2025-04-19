// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol UseCase {
    func signUp() -> AnyPublisher<AnyUser, Error>

    func checkAccountLinkedSocialId(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error>
}

public struct UseCaseImpl {
    let serverRepository: ServerRepository
    let keychainRepository: JwtRepository

    public init(
        serverRepository: ServerRepository,
        keychainRepository: JwtRepository
    ) {
        self.serverRepository = serverRepository
        self.keychainRepository = keychainRepository
    }
}

extension UseCaseImpl: UseCase {
    public func checkAccountLinkedSocialId(with socialIdData: SocialIdData) -> AnyPublisher<AnyUser?, Error> {
        fatalError()
    }

    public func signUp() -> AnyPublisher<AnyUser, any Error> {
//        keychainRepository.save(<#T##token: AccessToken##AccessToken#>)

        fatalError()
    }
}
