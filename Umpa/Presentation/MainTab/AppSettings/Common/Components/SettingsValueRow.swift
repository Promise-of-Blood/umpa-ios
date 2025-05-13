// Created for Umpa in 2025

import SwiftUI

struct SettingsValueRow: View {
  let text: String
  let value: String

  var body: some View {
    HStack {
      Text(text)
      Spacer()
      Text(value)
        .foregroundStyle(UmpaColor.mainBlue)
    }
    .font(AppSettingsConstant.rowFont)
    .frame(maxWidth: .infinity, height: AppSettingsConstant.rowHeight, alignment: .leading)
  }
}
