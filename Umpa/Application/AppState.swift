// Created for Umpa in 2025

import Domain
import SwiftUI

final class AppState: ObservableObject {
    @Published var userData = UserData()
    @Published var appData = AppData()
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
        var myProfileNavigationPath = NavigationPath()
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
        var teacherFinder = TeacherFinderData()
        var loginInfo = LoginInfo()
        fileprivate init() {}
    }
}

extension AppState.UserData {
    struct TeacherFinderData {
        var selectedServiceType: ServiceType = .lesson
        var selectedSubject: Subject?
        var isDisplayedServiceTypeSelectOnBoarding = false
        fileprivate init() {}
    }

    struct LoginInfo {
        var currentUser: AnyUser?
        fileprivate init() {}
    }
}

// MARK: - AppData

extension AppState {
    struct AppData {
        var majorList: [Major] = []
        var collegeList: [College] = []
        var regionList: [RegionalLocalGovernment: [BasicLocalGovernment]] = [:]
        var subjectList: [Subject] = Subject.allCases
        fileprivate init() {}
    }
}

// MARK: - System

extension AppState {
    struct System {
        var isSplashFinished = false
        fileprivate init() {}
    }
}

// MARK: - Conveniences

extension AppState.UserData.LoginInfo {
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
