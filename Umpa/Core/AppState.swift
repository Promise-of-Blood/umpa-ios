// Created for Umpa in 2025

import SwiftUI

class AppState: ObservableObject {
    @Published var isSplashFinished = false
    @Published var currenteUser: (any User)? = nil
    @Published var majorList: [String] = []

    var isLoggedIn: Bool {
        currenteUser != nil
    }
}
