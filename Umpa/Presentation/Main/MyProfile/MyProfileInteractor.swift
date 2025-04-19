// Created for Umpa in 2025

import Foundation
import KakaoSDKUser
import NidThirdPartyLogin

@MainActor
protocol MyProfileInteractor {
    func logout()
}

struct DefaultMyProfileInteractor {
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}

extension DefaultMyProfileInteractor: MyProfileInteractor {
    func logout() {
        appState.reset()
        NidOAuth.shared.logout()
        UserApi.shared.logout { error in
            if let error {
                print(error)
            }
        }
    }
}
