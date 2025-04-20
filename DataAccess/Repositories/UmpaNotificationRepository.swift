// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultUmpaNotificationRepository {
    public init() {}
}

extension DefaultUmpaNotificationRepository: UmpaNotificationRepository {
    public func fetchMyNotificationList(with: Domain.AccessToken) -> AnyPublisher<[Domain.UmpaNotification], any Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubUmpaNotificationRepository {
    public init() {}
}

extension StubUmpaNotificationRepository: UmpaNotificationRepository {
    public func fetchMyNotificationList(with: Domain.AccessToken) -> AnyPublisher<[Domain.UmpaNotification], any Error> {
        let notifications: [Domain.UmpaNotification] = [
            .init(id: "umpaNotification0", title: "Test Notification"),
        ]
        return Just(notifications)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif
