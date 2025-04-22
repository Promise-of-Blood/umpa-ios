// Created for Umpa in 2025

import SwiftUI

struct SignUpBottomButton: View {
    @Environment(\.isEnabled) private var isEnabled

    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
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
    SignUpBottomButton(text: "다음") {
        print("Tapped!")
    }
}
