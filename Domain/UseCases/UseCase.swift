// Created for Umpa in 2025

import Combine

public protocol UseCase {
    func loginWithApple() -> AnyPublisher<any User, Error>
    func loginWithKakao() -> AnyPublisher<any User, Error>
    func loginWithGoogle() -> AnyPublisher<any User, Error>
    func loginWithNaver() -> AnyPublisher<any User, Error>

    func signUp() -> AnyPublisher<any User, Error>

    func checkAccountLinkedSocialId() -> AnyPublisher<(any User)?, Error>
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
    public func checkAccountLinkedSocialId() -> AnyPublisher<(any User)?, any Error> {
        fatalError()
    }

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

    public func signUp() -> AnyPublisher<any User, any Error> {
//        keychainRepository.save(<#T##token: AccessToken##AccessToken#>)

        fatalError()
    }
}

public enum UseCaseError: Error {
//    case loginError
}

//#if DEBUG
//public final class UseCaseMock: UseCase {
//    public init() {}
//
//    var isLoginAsStudent: Bool!
//    var isLoginAsTeacher: Bool!
//
//    public func setStubToLoginAs(_ userType: UserType) {
//        switch userType {
//        case .student:
//            isLoginAsStudent = true
//            isLoginAsTeacher = false
//        case .teacher:
//            isLoginAsStudent = false
//            isLoginAsTeacher = true
//        }
//    }
//
//    public func setStubToLoginFailed() {
//        isLoginAsStudent = false
//        isLoginAsTeacher = false
//    }
//
//    public func loginWithApple() -> AnyPublisher<any User, any Error> {
//        if isLoginAsStudent {}
//        Just(Student.sample0)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
//
//    public func loginWithKakao() -> AnyPublisher<any User, any Error> {
//        <#code#>
//    }
//
//    public func loginWithGoogle() -> AnyPublisher<any User, any Error> {
//        <#code#>
//    }
//
//    public func loginWithNaver() -> AnyPublisher<any User, any Error> {
//        <#code#>
//    }
//
//    public func signUp() -> AnyPublisher<any User, any Error> {
//        <#code#>
//    }
//
//    public func checkAccountLinkedSocialId() -> AnyPublisher<(any User)?, any Error> {
//        <#code#>
//    }
//}
//#endif
