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
    private let regionRepository: RegionRepository
    private let lessonSubjectRepository: LessonSubjectRepository
    private let accompanimentInstrumentRepository: AccompanimentInstrumentRepository

    private let cancelBag = CancelBag()

    init(
        appState: AppState,
        collegeRepository: CollegeRepository,
        majorRepository: MajorRepository,
        regionRepository: RegionRepository,
        lessonSubjectRepository: LessonSubjectRepository,
        accompanimentInstrumentRepository: AccompanimentInstrumentRepository,
    ) {
        self.appState = appState
        self.collegeRepository = collegeRepository
        self.majorRepository = majorRepository
        self.regionRepository = regionRepository
        self.lessonSubjectRepository = lessonSubjectRepository
        self.accompanimentInstrumentRepository = accompanimentInstrumentRepository

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
        let part1 = Publishers.Zip4(
            collegeRepository.fetchCollegeList(),
            majorRepository.fetchMajorList(),
            regionRepository.fetchRegionList(),
            lessonSubjectRepository.fetchLessonSubjectList(),
        )
        let part2 = accompanimentInstrumentRepository.fetchAccompanimentInstrumentList()

        Publishers.Zip(
            part1, part2
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if completion.isError {
                // TODO: Handle error - 앱을 시작할 수 없음
            }
        } receiveValue: { [appState] part1, part2 in
            appState.appData.collegeList = part1.0
            appState.appData.majorList = part1.1
            appState.appData.regionList = part1.2
            appState.appData.lessonSubjectList = part1.3
            appState.appData.accompanimentInstrumentList = part2
            appState.system.isSplashFinished = true
        }
        .store(in: cancelBag)
    }
}
