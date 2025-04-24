// Created for Umpa in 2025

import SwiftUI

struct SignUpBottomButton<Content>: View where Content: View {
    @Environment(\.isEnabled) private var isEnabled

    let action: () -> Void

    @ViewBuilder let label: () -> Content

    var body: some View {
        Button(action: action) {
            label()
                .font(.pretendardBold(size: fs(20)))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, idealHeight: 71)
                .fixedSize(horizontal: false, vertical: true)
                .background(isEnabled ? UmpaColor.mainBlue : Color.gray, in: RoundedRectangle(cornerRadius: 12))
                .padding()
        }
    }
}

#Preview {
    SignUpBottomButton {
        print("Tapped!")
    } label: {
        Text("다음")
    }
}
