// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

protocol TeacherHomeInteractor {
    func fetchMyLessonAndServiceList(_ list: LoadableBinding<[AnyService]>)
}

struct TeacherHomeInteractorImpl {
    @Injected(\.stubServerRepository) private var serverRepository
    @Injected(\.getAccessTokenUseCase) private var getAccessToken
}

extension TeacherHomeInteractorImpl: TeacherHomeInteractor {
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
