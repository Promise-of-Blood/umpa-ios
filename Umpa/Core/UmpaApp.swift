//
//  UmpaApp.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import Factory
import Networking
import SwiftUI

@main
struct UmpaApp: App {
    @InjectedObject(\.appState) private var appState: AppState
    @Injected(\.appInteractor) private var appInteractor: AppInteractor

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
                        await appInteractor.loadMajorList()
                        appState.isSplashFinished = true
                    }
            }
        }
    }
}
