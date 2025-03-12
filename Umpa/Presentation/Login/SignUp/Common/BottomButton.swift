// Created for Umpa in 2025

import SwiftUI

struct BottomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, idealHeight: 71)
            .fixedSize(horizontal: false, vertical: true)
            .background(Color.main, in: RoundedRectangle(cornerRadius: 5))
            .padding()
    }
}

#Preview {
    Text("Button")
        .modifier(BottomButton())
}
