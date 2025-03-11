// Created for Umpa in 2025

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            .padding(.top, 50)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Text("앱의 이용 목적에 따라\n선택해주세요")
        .modifier(TitleText())
}
