// Created for Umpa in 2025

import Combine
import Domain
import Foundation

enum KeychainRepositoryError: Error {
    case notSaved(OSStatus)
    case notFound(OSStatus)
}

public struct DefaultKeychainRepository {
    public init() {
        let infoDictionaryKey = "KEYCHAIN_ACCESS_TOKEN_KEY_RELEASE"
        guard let key = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String else {
            fatalError("해당 Info.plist 키가 존재하지 않습니다.")
        }
        accessTokenKey = key
    }

    private let accessTokenKey: String
}

extension DefaultKeychainRepository: KeychainRepository {
    public func save(_ token: Domain.AccessToken) -> AnyPublisher<Void, any Error> {
        let data = Data(token.utf8)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessTokenKey,
            kSecValueData: data,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)

        if status != errSecSuccess {
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: KeychainRepositoryError.notSaved(status))
                .eraseToAnyPublisher()
        }
    }

    public func getAccessToken() -> AnyPublisher<Domain.AccessToken, any Error> {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessTokenKey,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess,
           let data = dataTypeRef as? Data,
           let token = String(data: data, encoding: .utf8)
        {
            return Just(token)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: KeychainRepositoryError.notFound(status))
                .eraseToAnyPublisher()
        }
    }
}

#if MOCK

public final class StubKeychainRepository {
    public init() {}

    var accessToken: String?
}

extension StubKeychainRepository: KeychainRepository {
    public func save(_ token: Domain.AccessToken) -> AnyPublisher<Void, any Error> {
        accessToken = token
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func getAccessToken() -> AnyPublisher<Domain.AccessToken, any Error> {
        guard let accessToken = accessToken else {
            return Fail(error: KeychainRepositoryError.notFound(-1))
                .eraseToAnyPublisher()
        }
        return Just(accessToken)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

#endif
