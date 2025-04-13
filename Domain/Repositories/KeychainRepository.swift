// Created for Umpa in 2025

import Combine
import Foundation

public protocol KeychainRepository {
    func save(_ token: AccessToken) -> AnyPublisher<Void, Error>
    func getAccessToken() -> AnyPublisher<AccessToken, Error>
}
