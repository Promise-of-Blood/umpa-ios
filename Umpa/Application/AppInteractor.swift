// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import Mockable

@MainActor
protocol AppInteractor {
    func loadAppData()
}

struct DefaultAppInteractor {
    private let appState: AppState

    private let collegeRepository: CollegeRepository
    private let majorRepository: MajorRepository

    private let cancelBag = CancelBag()

    init(appState: AppState, collegeRepository: CollegeRepository, majorRepository: MajorRepository) {
        self.appState = appState
        self.collegeRepository = collegeRepository
        self.majorRepository = majorRepository

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
        if let mockMajorRepository = majorRepository as? MockMajorRepository {
            given(mockMajorRepository)
                .fetchMajorList()
                .willReturn(
                    Just([
                        Major(name: "피아노"),
                        Major(name: "작곡"),
                        Major(name: "드럼"),
                        Major(name: "베이스"),
                        Major(name: "기타"),
                        Major(name: "보컬"),
                        Major(name: "전자음악"),
                        Major(name: "관악"),
                    ])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                )
        }
    }
    #endif
}

extension DefaultAppInteractor: AppInteractor {
    func loadAppData() {
        Publishers.Zip(
            collegeRepository.fetchCollegeList(),
            majorRepository.fetchMajorList(),
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if completion.isError {
                // TODO: Handle error - 앱을 시작할 수 없음
            }
        } receiveValue: { [appState] collegeList, majorList in
            appState.appData.collegeList = collegeList
            appState.appData.majorList = majorList
            appState.system.isSplashFinished = true
        }
        .store(in: cancelBag)
    }
}
