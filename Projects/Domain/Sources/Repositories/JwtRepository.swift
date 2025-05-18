// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol JwtRepository {
    func setAccessToken(_ token: AccessToken) -> AnyPublisher<Void, Error>
    func getAccessToken() -> AnyPublisher<AccessToken?, Error>
}
