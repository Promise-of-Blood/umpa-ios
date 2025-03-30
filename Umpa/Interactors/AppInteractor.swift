// Created for Umpa in 2025

import Factory
import Foundation
import Networking

protocol AppInteractor {
    @MainActor func loadMajorList() async
}

struct DefaultAppInteractor: AppInteractor {
    @Injected(\.appState) var appState
    @Injected(\.umpaApi) var umpaApi

    func loadMajorList() async {
        let majors = await umpaApi.fetchMajors()
        appState.majorList = majors.map(\.name)
    }
}

#if MOCK
struct MockAppInteractor: AppInteractor {
    @Injected(\.appState) var appState

    func loadMajorList() async {
        appState.majorList = [
            "피아노",
            "작곡",
            "드럼",
            "베이스",
            "기타",
            "보컬",
            "전자음악",
            "관악",
        ]
    }
}
#endif
