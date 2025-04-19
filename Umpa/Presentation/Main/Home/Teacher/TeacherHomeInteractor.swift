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
    private let serverRepository: ServerRepository
    private let getAccessToken: GetAccessTokenUseCase

    init(serverRepository: ServerRepository, getAccessTokenUseCase: GetAccessTokenUseCase) {
        self.serverRepository = serverRepository
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
            .flatMap(serverRepository.fetchMyLessonAndServiceList(with:))
            .sinkToLoadable(list)
            .store(in: cancelBag)
    }
}
