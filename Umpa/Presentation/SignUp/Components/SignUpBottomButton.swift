// Created for Umpa in 2025

import SwiftUI

struct SignUpBottomButton<Content>: View where Content: View {
    @Environment(\.isEnabled) private var isEnabled

    let action: () -> Void

    @ViewBuilder let label: () -> Content

    var body: some View {
        Button(action: action) {
            label()
                .font(.pretendardSemiBold(size: fs(17)))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, idealHeight: fs(56))
                .fixedSize(horizontal: false, vertical: true)
                .background(isEnabled ? UmpaColor.mainBlue : Color.gray, in: RoundedRectangle(cornerRadius: fs(10)))
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
