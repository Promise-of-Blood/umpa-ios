// Created for Umpa in 2025

import SwiftUI
import UmpaComponents

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
        .modifier(NavigationBackButton(.arrowBack))
    }

    var nicknameTextField: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundStyle(UmpaColor.lightGray)
            TextField(
                "닉네임",
                text: $name,
                prompt: Text("닉네임을 입력해주세요")
            )
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(UmpaColor.lightGray)
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
