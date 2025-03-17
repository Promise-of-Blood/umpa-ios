// Created for Umpa in 2025

import SwiftUI

struct BottomActionBar: View {
    private let buttonsHeight: CGFloat = 50
    private let buttonsRadius: CGFloat = 10

    var body: some View {
        HStack(spacing: 8) {
            Button(action: didTapFavoriteButton) {
                Image(systemName: "heart")
                    .foregroundStyle(Color.black)
                    .frame(width: buttonsHeight, height: buttonsHeight)
                    .overlay {
                        RoundedRectangle(cornerRadius: buttonsRadius)
                            .strokeBorder(Color(hex: "EBEBEB"))
                    }
            }
            Button(action: didTapPrimaryButton) {
                Text("채팅 하기")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, idealHeight: buttonsHeight)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color.main, in: RoundedRectangle(cornerRadius: buttonsRadius))
            }
        }
    }

    func didTapFavoriteButton() {}

    func didTapPrimaryButton() {}
}

#Preview(traits: .sizeThatFitsLayout) {
    BottomActionBar()
}
