// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

@MainActor
protocol UmpaNotificationInteractor {
    func load(_ notificationList: LoadableBinding<[UmpaNotification]>)
}

struct DefaultUmpaNotificationInteractor {
    private var serverRepository: ServerRepository
    private var getAccessToken: GetAccessTokenUseCase

    init(
        serverRepository: ServerRepository,
        getAccessTokenUseCase: GetAccessTokenUseCase
    ) {
        self.serverRepository = serverRepository
        self.getAccessToken = getAccessTokenUseCase
    }
}

extension DefaultUmpaNotificationInteractor: UmpaNotificationInteractor {
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
