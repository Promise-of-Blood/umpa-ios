// Created for Umpa in 2025

import SwiftUI

struct BottomActionBar: View {
    private let height: CGFloat = fs(50)
    private let buttonsRadius: CGFloat = fs(10)

    var body: some View {
        HStack(spacing: fs(8)) {
            Button(action: didTapFavoriteButton) {
                Image(systemName: "heart") // TODO: 실제 리소스로 교체
                    .foregroundStyle(Color.black)
                    .frame(width: height, height: height)
                    .innerStroke(Color(hex: "EBEBEB"), cornerRadius: buttonsRadius, lineWidth: fs(1))
            }
            Button(action: didTapPrimaryButton) {
                Text("채팅 하기")
                    .font(.pretendardMedium(size: fs(15)))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .fill, idealHeight: height)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(UmpaColor.main, in: RoundedRectangle(cornerRadius: buttonsRadius))
            }
        }
        .frame(maxWidth: .fill, idealHeight: height)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, fs(14))
        .padding(.vertical, fs(8))
    }

    func didTapFavoriteButton() {}

    func didTapPrimaryButton() {}
}

#Preview(traits: .sizeThatFitsLayout) {
    BottomActionBar()
}
