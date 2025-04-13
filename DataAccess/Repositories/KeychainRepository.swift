// Created for Umpa in 2025

import Domain
import Foundation

public struct DefaultKeychainRepository {
    public init() {
        accessTokenKey = Bundle.main.object(forInfoDictionaryKey: "KEYCHAIN_ACCESS_TOKEN_KEY_RELEASE") as! String
    }

    private let accessTokenKey: String
}

extension DefaultKeychainRepository: KeychainRepository {
    public func save(_ token: Domain.AccessToken) {
        let data = Data(token.utf8)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessTokenKey,
            kSecValueData: data,
        ]
        SecItemAdd(query as CFDictionary, nil)
    }

    public func getAccessToken() -> Domain.AccessToken? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: accessTokenKey,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

#if MOCK

public final class StubKeychainRepository {
    public init() {}

    var accessToken: String?
}

extension StubKeychainRepository: KeychainRepository {
    public func save(_ token: Domain.AccessToken) {
        accessToken = token
    }

    public func getAccessToken() -> Domain.AccessToken? {
        accessToken
    }
}

#endif
