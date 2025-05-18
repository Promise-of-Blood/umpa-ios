// Created for Umpa in 2025

import SwiftUI

struct AccountManagementSettingsView: View {
  var body: some View {
    content
      .navigationTitle("계정 관리")
      .navigationBarTitleDisplayMode(.inline)
  }

  var content: some View {
    ScrollView {
      VStack(spacing: Constant.sectionSpacing) {
        SettingsSection {
          SettingsNormalRow(text: "연결된 서비스")
          SettingsButtonRow(text: "학생 계정으로 전환") {
            // TODO: Implement
          }
          SettingsButtonRow(text: "로그아웃") {
            // TODO: Implement
          }
          SettingsButtonRow(text: "탈퇴하기") {
            // TODO: Implement
          }
        }
      }
      .padding(.horizontal, Constant.listHorizontalPadding)
      .padding(.vertical, Constant.listVerticalPadding)
    }
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }
}

#Preview {
  AccountManagementSettingsView()
}
