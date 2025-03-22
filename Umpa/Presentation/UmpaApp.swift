//
//  UmpaApp.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import SwiftUI

@main
struct UmpaApp: App {
    @ObservedObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }
        .environmentObject(appState)
    }
}

class AppState: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentTabIndex = 0
}
