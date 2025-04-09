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
    @InjectedObject(\.appState) private var appState
    @Injected(\.appInteractor) private var appInteractor

    init() {
        #if MOCK
        Container.shared.appInteractor.register { MockAppInteractor() }
        Container.shared.signUpInteractor.register { MockSignUpInteractor() }
        Container.shared.serviceInteractor.register { MockServiceInteractor() }
        Container.shared.generalBoardInteractor.register { MockGeneralBoardInteractor() }
        Container.shared.reviewInteractor.register { MockReviewInteractor() }
        Container.shared.acceptanceReviewInteractor.register { MockAcceptanceReviewInteractor() }
        Container.shared.chatInteractor.register { MockChatInteractor() }
        Container.shared.mentoringInteractor.register { MockMentoringInteractor() }
        #endif
    }

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
                    .task {
                        await appInteractor.loadMajorList()
                        appState.system.isSplashFinished = true
                    }
            }
        }
    }
}
