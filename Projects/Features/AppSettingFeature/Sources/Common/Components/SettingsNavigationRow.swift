// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI

struct SettingsNavigationRow: View {
  let text: String
  let destination: AppSettingsView.NavigationDestination

  var body: some View {
    NavigationLink(value: destination) {
      HStack {
        Text(text)
          .font(Constant.rowFont)
        Spacer()
        Image(systemSymbol: .chevronRight)
          .font(.system(size: 14, weight: .regular))
      }
      .foregroundStyle(Color(UIColor.label))
      .frame(maxWidth: .infinity, height: Constant.rowHeight, alignment: .leading)
    }
  }
}
