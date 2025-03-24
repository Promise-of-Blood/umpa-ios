// Created for Umpa in 2025

import Factory
import Foundation
import Networking

struct AppInteractor {
    @Injected(\.appState) var appState
    @Injected(\.umpaApi) var umpaApi

    @MainActor
    func loadMajorList() async {
        let majors = await umpaApi.fetchMajors()
        appState.majorList = majors.map(\.name)
    }
}
