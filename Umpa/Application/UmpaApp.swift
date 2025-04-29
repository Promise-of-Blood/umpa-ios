// Created for Umpa in 2025

import Core
import Factory
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import NidThirdPartyLogin
import SwiftUI

@main
struct UmpaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @InjectedObject(\.appState) private var appState

    #if DEBUG
    @Injected(\.mockAppInteractor)
    #else
    @Injected(\.appInteractor)
    #endif
    private var appInteractor

    init() {
        NetworkMonitor.shared.start()
        prepareKakaoLogin()
        prepareNaverLogin()
        appInteractor.loadAppData()
    }

    var body: some Scene {
        WindowGroup {
            mainWindow
                .onOpenURL(perform: handleUrl)
                .task(restorePreviousSignIn)
        }
    }

    @ViewBuilder
    var mainWindow: some View {
        if appState.system.isSplashFinished {
            if appState.userData.loginInfo.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        } else {
            SplashView()
        }
    }
}

// MARK: - Private Methods

extension UmpaApp {
    private func prepareKakaoLogin() {
        let appKey = Bundle.main.infoPlist.string(forKey: .kakaoNativeAppKey)
        KakaoSDK.initSDK(appKey: appKey)
    }

    private func prepareNaverLogin() {
        NidOAuth.shared.initialize()
        NidOAuth.shared.setLoginBehavior(.appPreferredWithInAppBrowserFallback)
    }

    private func handleUrl(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            if !AuthController.handleOpenUrl(url: url) {
                UmpaLogger.log("카카오 리다이렉트 URL 처리 실패", level: .error)
            }
            return
        }
        if NidOAuth.shared.handleURL(url) {
            return
        }
        if GIDSignIn.sharedInstance.handle(url) {
            return
        }
    }

    @Sendable
    private func restorePreviousSignIn() async {
        do {
            let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            // Check if `user` exists; otherwise, do something with `error`
            UmpaLogger.log(user.description, level: .debug)
        } catch {
            UmpaLogger.log("Error restoring sign-in: \(error)", level: .error)
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
