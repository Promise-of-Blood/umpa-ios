// Created for Umpa in 2025

import DataAccess
import Factory
import KakaoSDKAuth
import KakaoSDKCommon
import NidThirdPartyLogin
import SwiftUI

@main
struct UmpaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @InjectedObject(\.appState) private var appState
    @Injected(\.appInteractor) private var appInteractor

    init() {
        prepareKakaoLogin()
        prepareNaverLogin()
    }

    var body: some Scene {
        WindowGroup {
            mainWindow
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                        return
                    }
                    if NidOAuth.shared.handleURL(url) == true {
                        return
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
}

// MARK: - Private Methods

extension UmpaApp {
    private func prepareKakaoLogin() {
        guard let appKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String else {
            return
        }
        KakaoSDK.initSDK(appKey: appKey)
    }

    private func prepareNaverLogin() {
        NidOAuth.shared.initialize()
        NidOAuth.shared.setLoginBehavior(.appPreferredWithInAppBrowserFallback)
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
