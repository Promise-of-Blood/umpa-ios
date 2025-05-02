// Created for Umpa in 2025

import SwiftUI

struct TitleText: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(SignUpConstant.titleFont)
            .foregroundStyle(SignUpConstant.titleColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TitleText("앱의 이용 목적에 따라 선택해주세요")
}
