// Created for Umpa in 2025

import Factory
import Foundation
import Networking

struct AppInteractor {
    @Injected(\.appState) var appState: AppState
    @Injected(\.umpaApi) var umpaApi: UmpaApi

    @MainActor
    func loadMajorList() async {
        let majors = await umpaApi.fetchMajors()
        appState.majorList = majors.map(\.name)
    }
}
