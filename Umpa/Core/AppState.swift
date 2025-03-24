// Created for Umpa in 2025

import SwiftUI

class AppState: ObservableObject {
    @Published var isSplashFinished = false
    @Published var isLoggedIn = false
    @Published var majorList: [String] = []
}
