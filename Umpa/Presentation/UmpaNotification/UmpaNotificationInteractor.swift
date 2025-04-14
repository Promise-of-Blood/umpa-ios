// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol UmpaNotificationInteractor {
    func load(_ notificationList: LoadableBinding<[UmpaNotification]>)
}

struct UmpaNotificationInteractorImpl {
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository
}

extension UmpaNotificationInteractorImpl: UmpaNotificationInteractor {
    func load(_ notificationList: LoadableBinding<[Domain.UmpaNotification]>) {
        let cancelBag = CancelBag()
        notificationList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyNotificationList(with:))
            .sinkToLoadable(notificationList)
            .store(in: cancelBag)
    }
}
