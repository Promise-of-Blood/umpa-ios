// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct AppSettingsView: View {
  enum NavigationDestination: Hashable {
    case accountManagement
  }

  @InjectedObject(\.appState) private var appState

  var body: some View {
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

  var content: some View {
    ScrollView {
      VStack(spacing: AppSettingsConstant.sectionSpacing) {
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
            // TOOD: Implement
          }
          SettingsButtonRow(text: "오픈 소스 라이선스") {
            // TOOD: Implement
          }
          SettingsButtonRow(text: "이용 약관") {
            // TOOD: Implement
          }
        } header: {
          SettingsSectionHeader(title: "기타")
        }
      }
      .padding(.horizontal, AppSettingsConstant.listHorizontalPadding)
      .padding(.vertical, AppSettingsConstant.listVerticalPadding)
    }
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }
}

#Preview {
  AppSettingsView()
}
