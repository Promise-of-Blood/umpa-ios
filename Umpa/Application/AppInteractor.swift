// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import Mockable

@MainActor
protocol AppInteractor {
    func loadCollegeList()
}

struct DefaultAppInteractor {
    private let appState: AppState

    private let collegeRepository: CollegeRepository

    private let cancelBag = CancelBag()

    init(appState: AppState, collegeRepository: CollegeRepository) {
        self.appState = appState
        self.collegeRepository = collegeRepository

        #if DEBUG
        setupMockBehavior()
        #endif
    }

    #if DEBUG
    private func setupMockBehavior() {
        if let mockCollegeRepository = collegeRepository as? MockCollegeRepository {
            given(mockCollegeRepository)
                .fetchCollegeList()
                .willReturn(
                    Just([
                        College(name: "서울대학교"),
                        College(name: "고려대학교"),
                        College(name: "연세대학교"),
                        College(name: "성균관대학교"),
                        College(name: "한양대학교"),
                        College(name: "중앙대학교"),
                        College(name: "경희대학교"),
                        College(name: "서강대학교"),
                    ])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                )
        }
    }
    #endif
}

extension DefaultAppInteractor: AppInteractor {
    func loadCollegeList() {
        collegeRepository.fetchCollegeList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if completion.isError {
                    // TODO: Handle error
                }
            } receiveValue: { [appState] collegeList in
                appState.userData.collegeList = collegeList.map(\.name)
            }
            .store(in: cancelBag)
    }
}
