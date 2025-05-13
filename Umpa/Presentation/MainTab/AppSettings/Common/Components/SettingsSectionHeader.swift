// Created for Umpa in 2025

import SwiftUI

struct SettingsSectionHeader: View {
  let title: String

  var body: some View {
    Text(title)
      .font(AppSettingsConstant.sectionFont)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, fs(10))
  }
}
