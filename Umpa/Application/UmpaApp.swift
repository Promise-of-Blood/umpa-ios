//
//  UmpaApp.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import DataAccess
import Factory
import SwiftUI

@main
struct UmpaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @InjectedObject(\.appState) private var appState
    @Injected(\.appInteractor) private var appInteractor

    var body: some Scene {
        WindowGroup {
            if appState.system.isSplashFinished {
                if appState.userData.isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            } else {
                SplashView()
                    .onAppear {
                        appInteractor.loadMajorList()
                    }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // Record the device token.
    }
}
