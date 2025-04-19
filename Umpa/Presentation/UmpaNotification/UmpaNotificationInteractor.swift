// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

protocol UmpaNotificationInteractor {
    func load(_ notificationList: LoadableBinding<[UmpaNotification]>)
}

struct UmpaNotificationInteractorImpl {
    @Injected(\.stubServerRepository) private var serverRepository
//    @Injected(\.keychainRepository) private var keychainRepository
    @Injected(\.getAccessTokenUseCase) private var getAccessToken
}

extension UmpaNotificationInteractorImpl: UmpaNotificationInteractor {
    func load(_ notificationList: LoadableBinding<[Domain.UmpaNotification]>) {
        let cancelBag = CancelBag()
        notificationList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        getAccessToken()
            .tryMap { accessToken in
                guard let accessToken else { throw UmpaError.missingAccessToken }
                return accessToken
            }
            .flatMap(serverRepository.fetchMyNotificationList(with:))
            .sinkToLoadable(notificationList)
            .store(in: cancelBag)
    }
}
