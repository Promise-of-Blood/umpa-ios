// Created for Umpa in 2025

import BaseFeature
import SwiftUI
import UmpaUIKit

public struct AppSettingsView: View {
  enum NavigationDestination: Hashable {
    case accountManagement
  }

  @Environment(AppState.self) private var appState

  public init() {}

  public var body: some View {
    @Bindable var appState = appState
    NavigationStack(path: $appState.routing.settingsNavigationPath) {
      content
        .navigationDestination(for: NavigationDestination.self) { destination in
          switch destination {
          case .accountManagement:
            AccountManagementSettingsView()
          }
        }
        .navigationTitle("설정")
    }
  }

  @ViewBuilder
  var content: some View {
    @Bindable var appState = appState
    ScrollView {
      VStack(spacing: Constant.sectionSpacing) {
        SettingsSection {
          SettingsToggleSwitchRow(text: "채팅 알림", isOn: $appState.system.isChatNotificationEnabled)
        } header: {
          SettingsSectionHeader(title: "알림")
        }

        HorizontalDivider(color: UmpaColor.lightLightGray)

        SettingsSection {
          SettingsNavigationRow(text: "계정 관리", destination: .accountManagement)
        } header: {
          SettingsSectionHeader(title: "계정")
        }

        HorizontalDivider(color: UmpaColor.lightLightGray)

        SettingsSection {
          SettingsValueRow(text: "앱 버전", value: appState.system.appVersion)
          SettingsButtonRow(text: "개인 정보 처리 방침") {
            // TODO: Implement
          }
          SettingsButtonRow(text: "오픈 소스 라이선스") {
            // TODO: Implement
          }
          SettingsButtonRow(text: "이용 약관") {
            // TODO: Implement
          }
        } header: {
          SettingsSectionHeader(title: "기타")
        }
      }
      .padding(.horizontal, Constant.listHorizontalPadding)
      .padding(.vertical, Constant.listVerticalPadding)
    }
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }
}

#Preview {
  AppSettingsView()
}
