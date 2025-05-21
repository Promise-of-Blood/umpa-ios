// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

protocol SettingSheet: View {
  var titleFont: Font { get }
  func acceptButton(_ acceptAction: @escaping () -> Void) -> AnyView
}

extension SettingSheet {
  var titleFont: Font {
    .pretendardBold(size: fs(20))
  }

  func acceptButton(_ acceptAction: @escaping () -> Void) -> AnyView {
    AnyView(
      AcceptButton(acceptAction: acceptAction)
    )
  }
}

private struct AcceptButton: View {
  @Environment(\.isEnabled) private var isEnabled

  let acceptAction: () -> Void

  var body: some View {
    Button(action: acceptAction) {
      Text("완료")
        .font(.pretendardMedium(size: fs(15)))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, height: fs(50))
        .background(
          isEnabled ? UmpaColor.mainBlue : UmpaColor.disabled,
          in: RoundedRectangle(cornerRadius: fs(10))
        )
        .padding(.horizontal, fs(20))
        .padding(.top, fs(16))
    }
  }
}
