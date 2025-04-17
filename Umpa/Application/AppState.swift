// Created for Umpa in 2025

import Domain
import SwiftUI

final class AppState: ObservableObject {
    @Published var userData = UserData()
    @Published var routing = Routing()
    @Published var system = System()

    func reset() {
        userData = UserData()
        routing = Routing()
    }
}

// MARK: - Routing

extension AppState {
    struct Routing {
        var currentTab: MainViewTabType = .teacherFinder
        var chatNavigationPath = NavigationPath()
        var teacherFinderNavigationPath = NavigationPath()
        var myServicesNavigationPath = NavigationPath()
        var loginNavigationPath = NavigationPath()
    }
}

enum MainViewTabType: Int {
    case teacherHome = 0
    case teacherFinder
    case community
    case chat
    case myProfile
}

// MARK: - UserData

extension AppState {
    struct UserData {
        var teacherFinder = TeacherFinder()
        var login = Login()

        var majorList: [String] = []

        fileprivate init() {}
    }
}

extension AppState.UserData {
    struct TeacherFinder {
        var selectedService: ServiceType = .lesson
        var selectedSubject: Subject?

        fileprivate init() {}
    }

    struct Login {
        var currentUser: AnyUser?

        fileprivate init() {}
    }
}

extension AppState.UserData.Login {
    var isLoggedIn: Bool {
        currentUser != nil
    }

    var userType: UserType {
        get throws {
            guard let currentUser else {
                throw UserDataError.userNotLoggedIn
            }
            return currentUser.userType
        }
    }

    var isTeacher: Bool {
        (try? userType) == .teacher
    }

    var isStudent: Bool {
        (try? userType) == .student
    }
}

enum UserDataError: Error {
    case userNotLoggedIn
}

// MARK: - System

extension AppState {
    struct System {
        var isSplashFinished = false
    }
}
