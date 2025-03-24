// Created for Umpa in 2025

import SwiftUI

struct BottomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, idealHeight: 71)
            .fixedSize(horizontal: false, vertical: true)
            .background(UmpaColor.main, in: RoundedRectangle(cornerRadius: 12))
            .padding()
    }
}

#Preview {
    Text("Button")
        .modifier(BottomButton())
}
