// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol UseCase {
    func loginWithApple() -> AnyPublisher<AnyUser, Error>
    func loginWithKakao() -> AnyPublisher<AnyUser, Error>
    func loginWithGoogle() -> AnyPublisher<AnyUser, Error>
    func loginWithNaver() -> AnyPublisher<AnyUser, Error>

    func signUp() -> AnyPublisher<AnyUser, Error>

    func checkAccountLinkedSocialId() -> AnyPublisher<AnyUser?, Error>
}

public struct UseCaseImpl {
    let serverRepository: ServerRepository
    let keychainRepository: KeychainRepository

    public init(
        serverRepository: ServerRepository,
        keychainRepository: KeychainRepository
    ) {
        self.serverRepository = serverRepository
        self.keychainRepository = keychainRepository
    }
}

extension UseCaseImpl: UseCase {
    public func checkAccountLinkedSocialId() -> AnyPublisher<AnyUser?, any Error> {
        fatalError()
    }

    public func loginWithApple() -> AnyPublisher<AnyUser, any Error> {
//        serverRepository
//        keychainRepository.save(<#T##token: AccessToken##AccessToken#>)

        fatalError()
    }

    public func loginWithKakao() -> AnyPublisher<AnyUser, any Error> {
        fatalError()
    }

    public func loginWithGoogle() -> AnyPublisher<AnyUser, any Error> {
        fatalError()
    }

    public func loginWithNaver() -> AnyPublisher<AnyUser, any Error> {
        fatalError()
    }

    public func signUp() -> AnyPublisher<AnyUser, any Error> {
//        keychainRepository.save(<#T##token: AccessToken##AccessToken#>)

        fatalError()
    }
}

public enum UseCaseError: Error {
//    case loginError
}
