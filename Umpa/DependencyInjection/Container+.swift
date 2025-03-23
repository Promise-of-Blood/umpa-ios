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
        Factory(self) { AppInteractor() }
            .scope(.singleton)
    }

    var signUpInteractor: Factory<SignUpInteractor> {
        Factory(self) { SignUpInteractor() }
            .scope(.shared)
    }
}
