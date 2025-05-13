// Created for Umpa in 2025

import Components
import SwiftUI

struct SettingsToggleSwitchRow: View {
  let text: String
  @Binding var isOn: Bool

  var body: some View {
    HStack {
      Text(text)
        .font(AppSettingsConstant.rowFont)
      Spacer()
      ToggleSwitch(isOn: $isOn)
    }
    .frame(maxWidth: .infinity, height: AppSettingsConstant.rowHeight)
  }
}
