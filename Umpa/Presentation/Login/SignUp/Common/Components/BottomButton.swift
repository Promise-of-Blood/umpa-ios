// Created for Umpa in 2025

import SwiftUI

struct BottomButton: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content
            .font(.pretendardBold(size: fs(20)))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, idealHeight: 71)
            .fixedSize(horizontal: false, vertical: true)
            .background(isEnabled ? UmpaColor.main : Color.gray, in: RoundedRectangle(cornerRadius: 12))
            .padding()
    }
}

#Preview {
    Text("Button")
        .modifier(BottomButton())
}
