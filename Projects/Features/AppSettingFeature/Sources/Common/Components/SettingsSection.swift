// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct SettingsSection<Content: View, Header: View>: View {
  @ViewBuilder let content: () -> Content
  @ViewBuilder let header: () -> Header

  private let sectionHeaderSpacing: CGFloat = fs(4)
  private let rowSpacing: CGFloat = fs(4)

  init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder header: @escaping () -> Header) {
    self.content = content
    self.header = header
  }

  init(@ViewBuilder content: @escaping () -> Content) where Header == EmptyView {
    self.content = content
    header = { EmptyView() }
  }

  var body: some View {
    VStack(spacing: sectionHeaderSpacing) {
      header()
      VStack(spacing: rowSpacing) {
        content()
      }
    }
  }
}
