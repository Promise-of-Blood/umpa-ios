// Created for Umpa in 2025

import Core
import Domain
import Foundation
import SwiftUI

@Observable
public final class AppState {
  /// 사용자와 연관된 데이터.
  public var userData = UserData()

  /// 앱 실행에 필요한 데이터. 대부분 앱 시작 시 한 번만 받아오면 되는 데이터들.
  public var appData = AppData()

  /// 앱의 라우팅 상태.
  public var routing = Routing()

  /// 앱 설정, 앱의 전역 상태 등.
  public var system = System()

  public init() {}
}

// MARK: - Routing

extension AppState {
  @Observable
  public final class Routing {
    public var currentTab: MainViewTabType = .teacherFinder
    public var chatNavigationPath = NavigationPath()
    public var teacherFinderNavigationPath = NavigationPath()
    public var myServicesNavigationPath = NavigationPath()
    public var loginNavigationPath = NavigationPath()
    public var myProfileNavigationPath = NavigationPath()
    public var settingsNavigationPath = NavigationPath()

    public func reset() {
      currentTab = .teacherFinder
      chatNavigationPath = NavigationPath()
      teacherFinderNavigationPath = NavigationPath()
      myServicesNavigationPath = NavigationPath()
      loginNavigationPath = NavigationPath()
      myProfileNavigationPath = NavigationPath()
    }
  }
}

public enum MainViewTabType: Int {
  case teacherHome = 0
  case teacherFinder
  case community
  case chat
  case myProfile
  case appSettings
}

// MARK: - UserData

extension AppState {
  @Observable
  public final class UserData {
    public var teacherFinder = TeacherFinderData()
    public var loginInfo = LoginInfo()

    public func reset() {
      teacherFinder = TeacherFinderData()
      loginInfo = LoginInfo()
    }
  }
}

extension AppState.UserData {
  @Observable
  public final class TeacherFinderData {
    public var selectedServiceType: ServiceType = .lesson
    public var selectedSubject: LessonSubject?
    public var hasDisplayedServiceTypeSelectOnBoarding = false
  }

  @Observable
  public final class LoginInfo {
    public var currentUser: AnyUser?
  }
}

// MARK: - AppData

extension AppState {
  @Observable
  public final class AppData {
    public var majorList: [Major] = []
    public var collegeList: [College] = []
    public var regionList: [RegionalLocalGovernment: [BasicLocalGovernment]] = [:]
    public var lessonSubjectList: [LessonSubject] = []
    public var accompanimentInstrumentList: [AccompanimentInstrument] = []
  }
}

// MARK: - System

extension AppState {
  @Observable
  public final class System {
    public var isSplashFinished = false
    public var isChatNotificationEnabled = false
    public var appVersion: String = ""

    public let regionalLocalGovernmentListOrder: [String: Int] = [
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

    init() {
      let appVersion = Bundle.main.infoPlist.string(forKey: .CFBundleShortVersionString)
      self.appVersion = appVersion
    }
  }
}

// MARK: - Conveniences

extension AppState.UserData.LoginInfo {
  public var isLoggedIn: Bool {
    currentUser != nil
  }

  public var userType: UserType? {
    if let currentUser {
      currentUser.userType
    } else {
      nil
    }
  }

  public var isTeacher: Bool {
    userType == .teacher
  }

  public var isStudent: Bool {
    userType == .student
  }
}
