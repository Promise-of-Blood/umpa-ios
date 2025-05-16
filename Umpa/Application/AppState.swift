// Created for Umpa in 2025

import Core
import Domain
import Foundation
import SwiftUI

final class AppState: ObservableObject {
  /// 사용자와 연관된 데이터.
  @Published var userData = UserData()

  /// 앱 실행에 필요한 데이터. 대부분 앱 시작 시 한 번만 받아오면 되는 데이터들.
  @Published var appData = AppData()

  /// 앱의 라우팅 상태.
  @Published var routing = Routing()

  /// 앱 설정, 앱의 전역 상태 등.
  @Published var system = System()
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
    var settingsNavigationPath = NavigationPath()

    fileprivate init() {}

    mutating func reset() {
      currentTab = .teacherFinder
      chatNavigationPath = NavigationPath()
      teacherFinderNavigationPath = NavigationPath()
      myServicesNavigationPath = NavigationPath()
      loginNavigationPath = NavigationPath()
      myProfileNavigationPath = NavigationPath()
    }
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

    mutating func reset() {
      teacherFinder = TeacherFinderData()
      loginInfo = LoginInfo()
    }
  }
}

extension AppState.UserData {
  struct TeacherFinderData {
    var selectedServiceType: ServiceType = .lesson
    var selectedSubject: LessonSubject?
    var hasDisplayedServiceTypeSelectOnBoarding = false
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
    var lessonSubjectList: [LessonSubject] = []
    var accompanimentInstrumentList: [AccompanimentInstrument] = []
    fileprivate init() {}
  }
}

// MARK: - System

extension AppState {
  struct System {
    var isSplashFinished = false
    var isChatNotificationEnabled = false
    var appVersion: String = ""

    let regionalLocalGovernmentListOrder: [String: Int] = [
      "서울": 0,
      "인천": 1,
      "부산": 2,
      "대구": 3,
      "광주": 4,
      "대전": 5,
      "울산": 6,
      "세종": 7,
      "경기": 8,
      "강원": 9,
      "충북": 10,
      "충남": 11,
      "전북": 12,
      "전남": 13,
      "경북": 14,
      "경남": 15,
      "제주": 16,
    ]

    fileprivate init() {
      let appVersion = Bundle.main.infoPlist.string(forKey: .CFBundleShortVersionString)
      self.appVersion = appVersion
    }
  }
}

// MARK: - Conveniences

extension AppState.UserData.LoginInfo {
  var isLoggedIn: Bool {
    currentUser != nil
  }

  var userType: UserType? {
    if let currentUser {
      currentUser.userType
    } else {
      nil
    }
  }

  var isTeacher: Bool {
    userType == .teacher
  }

  var isStudent: Bool {
    userType == .student
  }
}
