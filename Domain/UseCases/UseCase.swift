// Created for Umpa in 2025

import Combine

public protocol UseCase {
    func loginWithApple() -> AnyPublisher<any User, Error>
    func loginWithKakao() -> AnyPublisher<any User, Error>
    func loginWithGoogle() -> AnyPublisher<any User, Error>
    func loginWithNaver() -> AnyPublisher<any User, Error>
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
    public func loginWithApple() -> AnyPublisher<any User, any Error> {
//        serverRepository
//        keychainRepository.save(<#T##token: AccessToken##AccessToken#>)

        fatalError()
    }

    public func loginWithKakao() -> AnyPublisher<any User, any Error> {
        fatalError()
    }

    public func loginWithGoogle() -> AnyPublisher<any User, any Error> {
        fatalError()
    }

    public func loginWithNaver() -> AnyPublisher<any User, any Error> {
        fatalError()
    }
}

public enum UseCaseError: Error {
    case loginError
}
