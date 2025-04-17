// Created for Umpa in 2025

import Combine
import Factory
import Foundation
import Utility

protocol AppInteractor {
    func loadMajorList()
}

struct DefaultAppInteractor: AppInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.stubServerRepository) private var serverRepository

    private let cancelBag = CancelBag()

    func loadMajorList() {
        serverRepository.fetchMajorList()
            .replaceError(with: [])
            .flatMap { [appState] in
                appState.userData.majorList = $0.map(\.name)
                return Just(())
            }
            .sink { [appState] in
                appState.system.isSplashFinished = true
            }
            .store(in: cancelBag)
    }
}
