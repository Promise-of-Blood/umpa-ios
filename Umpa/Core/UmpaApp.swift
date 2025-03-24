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
    @InjectedObject(\.appState) private var appState
    @Injected(\.appInteractor) private var appInteractor

    init() {
        #if DEBUG
        Container.shared.appInteractor.register { MockAppInteractor() }
        Container.shared.signUpInteractor.register { MockSignUpInteractor() }
        #endif
    }

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
