// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol UmpaNotificationRepository {
    func fetchMyNotificationList(with: AccessToken) -> AnyPublisher<[UmpaNotification], Error>
}
