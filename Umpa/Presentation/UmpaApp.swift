//
//  UmpaApp.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import Networking
import SwiftUI

@main
struct UmpaApp: App {
    @ObservedObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isSplashFinished {
                if appState.isLoggedIn {
                    MainView()
                } else {
                    LoginView()
                }
            } else {
                SplashView()
                    .task {
                        let majorInteractor = AppInteractor(appState: appState)
                        await majorInteractor.loadMajorList()
                        appState.isSplashFinished = true
                    }
            }
        }
        .environmentObject(appState)
    }
}

class AppState: ObservableObject {
    @Published var isSplashFinished = false
    @Published var isLoggedIn = false
    @Published var currentTabIndex = 0
    @Published var majorList: [String] = []
    @State var selectedMajor: String = ""
}

@MainActor
struct AppInteractor {
    let appState: AppState

    func loadMajorList() async {
        let majors = await UmpaApi.shared.fetchMajors()
        appState.majorList = majors.map(\.name)
    }
}
