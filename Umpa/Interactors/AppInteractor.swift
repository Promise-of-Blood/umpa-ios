// Created for Umpa in 2025

import DataAccess
import Factory
import Foundation

protocol AppInteractor {
    @MainActor
    func loadMajorList() async
}

struct DefaultAppInteractor: AppInteractor {
    @Injected(\.appState) var appState
    @Injected(\.umpaApi) var umpaApi

    func loadMajorList() async {
        let majors = await umpaApi.fetchMajors()
        appState.userData.majorList = majors.map(\.name)
    }
}

#if MOCK
struct MockAppInteractor: AppInteractor {
    @Injected(\.appState) var appState

    func loadMajorList() async {
        appState.userData.majorList = [
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
