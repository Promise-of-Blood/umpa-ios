// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI
import UmpaUIKit

@MainActor
protocol UmpaNotificationInteractor {
  func load(_ notificationList: LoadableBinding<[UmpaNotification]>)
}

struct DefaultUmpaNotificationInteractor {
  private var umpaNotificationRepository: UmpaNotificationRepository
  private var getAccessToken: GetAccessTokenUseCase

  init(
    umpaNotificationRepository: UmpaNotificationRepository,
    getAccessTokenUseCase: GetAccessTokenUseCase
  ) {
    self.umpaNotificationRepository = umpaNotificationRepository
    getAccessToken = getAccessTokenUseCase
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
      .flatMap(umpaNotificationRepository.fetchMyNotificationList(with:))
      .sinkToLoadable(notificationList)
      .store(in: cancelBag)
  }
}
