// Created for Umpa in 2025

import DataAccess
import Factory
import KakaoSDKAuth
import KakaoSDKCommon
import SwiftUI

@main
struct UmpaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @InjectedObject(\.appState) private var appState
    @Injected(\.appInteractor) private var appInteractor

    init() {
        KakaoSDK.initSDK(appKey: "NATIVE_APP_KEY")
    }

    var body: some Scene {
        WindowGroup {
            if appState.system.isSplashFinished {
                if appState.userData.login.isLoggedIn {
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
