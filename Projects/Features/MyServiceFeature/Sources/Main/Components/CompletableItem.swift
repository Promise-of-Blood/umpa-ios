// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct CompletableItem: View {
  @Binding var isCompleted: Bool
  let title: String
  let action: () -> Void

  private let highlightColor: Color = UmpaColor.mainBlue
  private let highlightGradient: LinearGradient = .init(
    gradient: Gradient(colors: [UmpaColor.mainBlue, Color(hex: "9AB5FF")]),
    startPoint: .leading,
    endPoint: .trailing
  )

  var body: some View {
    Button(action: action) {
      HStack(spacing: fs(8)) {
        if isCompleted {
          Image(systemSymbol: .checkmarkCircleFill)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(UmpaColor.mainBlue)
        }
        Text(title)
          .font(.pretendardMedium(size: fs(14)))
          .foregroundStyle(isCompleted ? AnyShapeStyle(highlightColor) : AnyShapeStyle(Color.black))
          .frame(maxWidth: .infinity, alignment: .leading)
        Image(systemSymbol: .chevronRight)
          .font(.system(size: 14, weight: .medium))
          .foregroundStyle(UmpaColor.mediumGray)
      }
      .padding(.horizontal, fs(16))
      .padding(.vertical, fs(14))
      .background(.white)
      .innerRoundedStroke(
        isCompleted ? AnyShapeStyle(highlightColor) : AnyShapeStyle(UmpaColor.lightGray),
        cornerRadius: fs(10),
        lineWidth: isCompleted ? fs(1.3) : fs(1)
      )
    }
  }
}

#Preview {
  CompletableItem(isCompleted: .constant(false), title: "항목 이름") {
    print("Tapped!")
  }
  .padding()

  CompletableItem(isCompleted: .constant(true), title: "항목 이름") {
    print("Tapped!")
  }
  .padding()
}
