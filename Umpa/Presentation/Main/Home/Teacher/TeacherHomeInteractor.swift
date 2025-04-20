// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

@MainActor
protocol TeacherHomeInteractor {
    func fetchMyLessonAndServiceList(_ list: LoadableBinding<[AnyService]>)
}

struct DefaultTeacherHomeInteractor {
    private let serviceRepository: ServiceRepository
    private let getAccessToken: GetAccessTokenUseCase

    init(serviceRepository: ServiceRepository, getAccessTokenUseCase: GetAccessTokenUseCase) {
        self.serviceRepository = serviceRepository
        self.getAccessToken = getAccessTokenUseCase
    }
}

extension DefaultTeacherHomeInteractor: TeacherHomeInteractor {
    func fetchMyLessonAndServiceList(_ list: LoadableBinding<[AnyService]>) {
        let cancelBag = CancelBag()
        list.wrappedValue.setIsLoading(cancelBag: cancelBag)
        getAccessToken()
            .tryMap { accessToken in
                guard let accessToken else { throw UmpaError.missingAccessToken }
                return accessToken
            }
            .flatMap(serviceRepository.fetchMyLessonAndServiceList(with:))
            .sinkToLoadable(list)
            .store(in: cancelBag)
    }
}
