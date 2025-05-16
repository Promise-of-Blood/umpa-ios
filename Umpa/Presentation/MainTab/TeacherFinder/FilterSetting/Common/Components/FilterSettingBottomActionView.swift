// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct FilterSettingBottomActionView: View {
  let applyButtonTitle: String
  let resetButtonTitle: String
  let applyAction: () -> Void
  let resetAction: () -> Void

  // MARK: Appearance

  private let buttonHeight: CGFloat = fs(50)
  private let cornerRadius: CGFloat = fs(10)

  // MARK: View

  var body: some View {
    HStack(spacing: fs(8)) {
      Button(action: resetAction) {
        VStack(spacing: fs(2)) {
          Image(systemSymbol: .arrowCounterclockwise)
            .font(.system(size: fs(20), weight: .medium))
          Text(resetButtonTitle)
            .font(.pretendardMedium(size: fs(8)))
        }
        .foregroundStyle(UmpaColor.mediumGray)
        .frame(width: buttonHeight, height: buttonHeight)
        .background(.white)
        .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: cornerRadius)
      }
      Button(action: applyAction) {
        Text(applyButtonTitle)
          .font(.pretendardMedium(size: fs(15)))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, height: buttonHeight)
          .background(UmpaColor.mainBlue, in: RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
    .frame(maxWidth: .infinity, height: buttonHeight)
    .padding(.horizontal, fs(14))
    .padding(.vertical, fs(8))
    .innerStroke(UmpaColor.lightLightGray, edges: .top)
  }
}

#Preview {
  FilterSettingBottomActionView(
    applyButtonTitle: "적용하기",
    resetButtonTitle: "초기화하기",
    applyAction: {},
    resetAction: {}
  )
}
