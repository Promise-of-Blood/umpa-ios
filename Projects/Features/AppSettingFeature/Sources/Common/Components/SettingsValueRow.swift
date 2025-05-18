// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

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
    .font(Constant.rowFont)
    .frame(maxWidth: .infinity, height: Constant.rowHeight, alignment: .leading)
  }
}
