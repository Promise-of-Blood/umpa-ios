// Created for Umpa in 2025

import SwiftUI

struct SignUpNicknameInputView: View {
    var body: some View {
        VStack {
            InputFieldLabelText("닉네임을 입력해주세요")
        }
        .modifier(BackButton())
    }
}

#Preview {
    SignUpNicknameInputView()
}
