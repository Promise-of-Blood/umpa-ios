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
        initKakaoSDK()
    }

    var body: some Scene {
        WindowGroup {
            mainWindow
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }

    @ViewBuilder
    var mainWindow: some View {
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

    private func initKakaoSDK() {
        guard let appKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String else {
            return
        }
        KakaoSDK.initSDK(appKey: appKey)
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
