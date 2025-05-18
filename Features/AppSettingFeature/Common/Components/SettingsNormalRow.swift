// Created for Umpa in 2025

import SwiftUI

struct SettingsNormalRow: View {
  let text: String

  var body: some View {
    Text(text)
      .font(Constant.rowFont)
      .frame(maxWidth: .infinity, height: Constant.rowHeight, alignment: .leading)
  }
}
