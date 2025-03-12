// Created for Umpa in 2025

import SwiftUI

struct SignUpNicknameInputView: View {
    @State private var name = ""

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            Text("닉네임을 입력해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                InputFieldLabelText("닉네임")
                nicknameTextField
            }
            Spacer()
            NavigationLink {
                SignUpMajorSelectionView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(BackButton())
    }

    var nicknameTextField: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundStyle(Color(hex: "#9E9E9E"))
            TextField(
                "닉네임",
                text: $name,
                prompt: Text("닉네임을 입력해주세요")
            )
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hex: "#9E9E9E"))
        }
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        SignUpNicknameInputView()
    }
}
