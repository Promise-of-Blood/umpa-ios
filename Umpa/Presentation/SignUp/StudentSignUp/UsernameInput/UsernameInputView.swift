// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct UsernameInputView: View {
    @ObservedObject var signUpModel: StudentSignUpModel
    @Binding var isSatisfiedCurrentInput: Bool

    @Binding var isDuplicatedUsername: ValueLoadable<Bool?>

    @FocusState private var isUsernameFieldFocused: Bool

    // MARK: View

    var body: some View {
        content
            .onAppear {
                isUsernameFieldFocused = true
            }
            .onChange(of: signUpModel.username) {
                isSatisfiedCurrentInput = signUpModel.validateUserName()
                isDuplicatedUsername.value = nil
            }
    }

    var content: some View {
        VStack(spacing: fs(80)) {
            Text("닉네임을 입력해주세요")
                .font(SignUpSharedUIConstant.titleFont)
                .foregroundStyle(SignUpSharedUIConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            nicknameTextField
        }
    }

    var nicknameTextField: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundStyle(UmpaColor.lightGray)
            TextField(
                "닉네임",
                text: $signUpModel.username,
                prompt: Text("닉네임을 입력해주세요")
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(UmpaColor.lightGray)
        }
        .focused($isUsernameFieldFocused)
        .onTapGesture {
            isUsernameFieldFocused = true
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UsernameInputView(
        signUpModel: StudentSignUpModel(socialLoginType: .apple),
        isSatisfiedCurrentInput: .constant(false),
        isDuplicatedUsername: .constant(.value(false))
    )
}
