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

struct Routing {
    var currentTab: MainViewTabType = .teacherFinder
    var chatNavigationPath = NavigationPath()
    var teacherFinderNavigationPath = NavigationPath()
    var myServicesNavigationPath = NavigationPath()
    var loginNavigationPath = NavigationPath()
}

enum MainViewTabType: Int {
    case teacherHome = 0
    case teacherFinder
    case community
    case chat
    case myProfile
}

// MARK: - UserData

struct UserData {
    struct TeacherFinder {
        var selectedService: ServiceType = .lesson
        var selectedSubject: Subject?

        fileprivate init() {}
    }

    struct Login {
        var currentUser: (any User)?

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

        fileprivate init() {}
    }

    var teacherFinder = TeacherFinder()
    var login = Login()

    var majorList: [String] = []

    fileprivate init() {}
}

enum UserDataError: Error {
    case userNotLoggedIn
}

// MARK: - System

struct System {
    var isSplashFinished = false
}
