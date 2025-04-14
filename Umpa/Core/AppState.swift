// Created for Umpa in 2025

import Domain
import SwiftUI

final class AppState: ObservableObject {
    @Published var userData = UserData()
    @Published var routing = ViewRouting()
    @Published var system = System()
}

struct ViewRouting {
    var currentTab: MainViewTabType = .home
    var chatNavigationPath = NavigationPath()
    var teacherFindingNavigationPath = NavigationPath()
    var myServicesNavigationPath = NavigationPath()
}

struct UserData {
    struct TeacherFinding {
        var selectedService: ServiceType = .lesson
        var selectedSubject: Subject?
    }

    var teacherFinding = TeacherFinding()

    var currentUser: (any User)?
    var majorList: [String] = []

    var isLoggedIn: Bool {
        currentUser != nil
    }
}

struct System {
    var isSplashFinished = false
}

enum MainViewTabType: Int {
    case home = 0
    case matching
    case community
    case chatting
}
