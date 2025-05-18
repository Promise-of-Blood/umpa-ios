// Created for Umpa in 2025

import Combine
import Core
import Domain
import Foundation

public struct DefaultJwtRepository {
    public init(persistentStorage: PersistentStorage) {
        self.persistentStorage = persistentStorage
        accessTokenKey = Bundle.main.infoPlist.value(forKey: .keychainAccessToken)
    }

    private let accessTokenKey: String

    private let persistentStorage: PersistentStorage
}

extension DefaultJwtRepository: JwtRepository {
    public func setAccessToken(_ token: Domain.AccessToken) -> AnyPublisher<Void, any Error> {
        return Result {
            try persistentStorage.set(token, forKey: accessTokenKey)
        }
        .publisher
        .eraseToAnyPublisher()
    }

    public func getAccessToken() -> AnyPublisher<Domain.AccessToken?, any Error> {
        return Result {
            try persistentStorage.load(key: accessTokenKey)
        }
        .publisher
        .eraseToAnyPublisher()
    }
}

extension AccessToken: StorableItem {
    public static func fromData(_ data: Data) throws -> AccessToken {
        try JSONDecoder().decode(AccessToken.self, from: data)
    }

    public func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
