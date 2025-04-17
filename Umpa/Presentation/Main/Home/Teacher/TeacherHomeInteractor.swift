// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol TeacherHomeInteractor {
    func fetchMyLessonAndServiceList(_ list: LoadableBinding<[AnyService]>)
}

struct TeacherHomeInteractorImpl {
    @Injected(\.stubServerRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository
}

extension TeacherHomeInteractorImpl: TeacherHomeInteractor {
    func fetchMyLessonAndServiceList(_ list: LoadableBinding<[AnyService]>) {
        let cancelBag = CancelBag()
        list.wrappedValue.setIsLoading(cancelBag: cancelBag)
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyLessonAndServiceList(with:))
            .sinkToLoadable(list)
            .store(in: cancelBag)
    }
}
