// Created for Umpa in 2025

import SwiftUI

@available(*, deprecated, message: "더 이상 사용되지 않음, 삭제 예정")
struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            .padding(.top, 28)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Text("앱의 이용 목적에 따라\n선택해주세요")
        .modifier(TitleText())
}
