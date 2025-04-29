// Created for Umpa in 2025

import SwiftUI

@available(*, deprecated, message: "삭제 예정 : SignUpSharedUIConstant.contentHorizontalPadding 사용")
struct InputContentVStack<Content>: View where Content: View {
    @ViewBuilder let content: Content

    let spacing: CGFloat?

    init(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
        }
        .padding(.horizontal, 30)
    }
}
