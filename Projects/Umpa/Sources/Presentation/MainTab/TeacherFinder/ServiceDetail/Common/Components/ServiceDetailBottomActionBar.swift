// Created for Umpa in 2025

import Combine
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct ServiceDetailBottomActionBar: View {
  @State private var isLiked: Bool

  private let height: CGFloat = ServiceDetailConstant.bottomActionBarHeight
  private let cornerRadius: CGFloat = fs(10)

  var buttonHeight: CGFloat {
    let verticalPadding = fs(16)
    return height - verticalPadding
  }

  let likeButtonAction: @MainActor (Bool) -> Void
  let primaryButtonAction: @MainActor () -> Void

  init(
    isLiked: Bool,
    likeButtonAction: @escaping (Bool) -> Void,
    primaryButtonAction: @escaping () -> Void
  ) {
    _isLiked = State(initialValue: isLiked)
    self.likeButtonAction = likeButtonAction
    self.primaryButtonAction = primaryButtonAction
  }

  var body: some View {
    HStack(spacing: fs(8)) {
      Button(action: {
        isLiked.toggle()
        likeButtonAction(isLiked)
      }) {
        Image(systemSymbol: isLiked ? .heartFill : .heart)
          .font(.system(size: 20, weight: .medium))
          .foregroundStyle(isLiked ? Color(hex: "FF4C4C") : UmpaColor.mediumGray)
          .frame(width: buttonHeight, height: buttonHeight)
          .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: cornerRadius, lineWidth: fs(1))
      }

      Button(action: primaryButtonAction) {
        Text("채팅 하기")
          .font(.pretendardMedium(size: fs(15)))
          .foregroundStyle(Color.white)
          .frame(maxWidth: .infinity, idealHeight: buttonHeight)
          .fixedSize(horizontal: false, vertical: true)
          .background(UmpaColor.mainBlue, in: RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
    .frame(maxWidth: .infinity, idealHeight: buttonHeight)
    .fixedSize(horizontal: false, vertical: true)
    .padding(.horizontal, fs(14))
    .padding(.vertical, fs(8))
    .background(Color.white)
    .shadow(color: .black.opacity(0.1), radius: 2, y: -1)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var currentState = false
  @Previewable @State var chatAttempts = 0

  Text(String(currentState))
    .padding()

  Text(String(chatAttempts))
    .padding()

  ServiceDetailBottomActionBar(
    isLiked: false,
    likeButtonAction: { isLiked in
      currentState = isLiked
    },
    primaryButtonAction: {
      chatAttempts += 1
    }
  )

  ServiceDetailBottomActionBar(
    isLiked: true,
    likeButtonAction: { isLiked in
      currentState = isLiked
    },
    primaryButtonAction: {
      chatAttempts += 1
    }
  )
}
