// Created for Umpa in 2025

import SwiftUI

struct BottomActionBar: View {
    @State private var isLiked: Bool

    let height: CGFloat
    private let buttonsRadius: CGFloat = fs(10)

    var buttonHeight: CGFloat {
        height - fs(16) // vertical padding
    }

    let likeButtonAction: @MainActor (Bool) -> Void
    let primaryButtonAction: @MainActor () -> Void

    init(
        height: CGFloat = fs(66),
        isLiked: Bool,
        likeButtonAction: @escaping (Bool) -> Void,
        primaryButtonAction: @escaping () -> Void
    ) {
        self.height = height
        self._isLiked = State(initialValue: isLiked)
        self.likeButtonAction = likeButtonAction
        self.primaryButtonAction = primaryButtonAction
    }

    var body: some View {
        HStack(spacing: fs(8)) {
            Button(action: {
                isLiked.toggle()
                likeButtonAction(isLiked)
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart") // TODO: 실제 리소스로 교체
                    .foregroundStyle(Color.black)
                    .frame(width: buttonHeight, height: buttonHeight)
                    .innerRoundedStroke(Color(hex: "EBEBEB"), cornerRadius: buttonsRadius, lineWidth: fs(1))
            }
            Button(action: primaryButtonAction) {
                Text("채팅 하기")
                    .font(.pretendardMedium(size: fs(15)))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .fill, idealHeight: buttonHeight)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(UmpaColor.main, in: RoundedRectangle(cornerRadius: buttonsRadius))
            }
        }
        .frame(maxWidth: .fill, idealHeight: buttonHeight)
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

    BottomActionBar(
        isLiked: false,
        likeButtonAction: { isLiked in
            currentState = isLiked
        },
        primaryButtonAction: {
            chatAttempts += 1
        }
    )

    BottomActionBar(
        isLiked: true,
        likeButtonAction: { isLiked in
            currentState = isLiked
        },
        primaryButtonAction: {
            chatAttempts += 1
        }
    )
}
