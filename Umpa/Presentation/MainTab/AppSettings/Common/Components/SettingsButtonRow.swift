// Created for Umpa in 2025

import SwiftUI

struct SettingsButtonRow: View {
  let text: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(text)
        .font(AppSettingsConstant.rowFont)
        .foregroundStyle(Color(UIColor.label))
        .frame(maxWidth: .infinity, height: AppSettingsConstant.rowHeight, alignment: .leading)
    }
  }
}
