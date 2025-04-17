// Created for Umpa in 2025

import Foundation
import KakaoSDKUser
import NidThirdPartyLogin

protocol MyProfileInteractor {
    func logout()
}

struct MyProfileInteractorImpl {
    let appState: AppState
}

extension MyProfileInteractorImpl: MyProfileInteractor {
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
