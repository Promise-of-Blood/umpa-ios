// Created for Umpa in 2025

import Factory
import Networking
import SwiftUI

extension Container {
    var appState: Factory<AppState> {
        Factory(self) { AppState() }
            .scope(.singleton)
    }

    var umpaApi: Factory<UmpaApi> {
        Factory(self) { UmpaApi() }
            .scope(.singleton)
    }

    var appInteractor: Factory<AppInteractor> {
        Factory(self) { DefaultAppInteractor() }
            .scope(.singleton)
    }

    var signUpInteractor: Factory<SignUpInteractor> {
        Factory(self) { DefaultSignUpInteractor() }
            .scope(.shared)
    }

    var signUpModel: Factory<SignUpModel> {
        Factory(self) { SignUpModel() }
            .scope(.signUpSession)
    }

    var mainViewModel: Factory<MainView.Model> {
        Factory(self) { MainView.Model() }
            .scope(.mainSession)
    }
}

extension Scope {
    static let signUpSession = Cached()
    static let mainSession = Cached()
}
