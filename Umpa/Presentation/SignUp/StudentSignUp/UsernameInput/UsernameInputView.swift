// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct UsernameInputView: View {
    @ObservedObject var signUpModel: StudentSignUpModel
    @Binding var isSatisfiedCurrentInput: Bool

    @Binding var isDuplicatedUsername: ValueLoadable<Bool?>

    var focusField: FocusState<StudentSignUpView.FocusField?>.Binding

    // MARK: View

    var body: some View {
        content
            .onAppear {
                focusField.wrappedValue = .username
            }
            .onChange(of: signUpModel.username) {
                isSatisfiedCurrentInput = signUpModel.validateUserName()
                isDuplicatedUsername.value = nil
            }
    }

    var content: some View {
        VStack(spacing: fs(80)) {
            Text("닉네임을 입력해주세요")
                .font(SignUpConstant.titleFont)
                .foregroundStyle(SignUpConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            nicknameTextField
        }
        .background(.white)
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
            .foregroundStyle(.black)
        }
        .padding()
        .backgroundStyle(.white)
        .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: fs(12))
        .focused(focusField, equals: .username)
        .onTapGesture {
            focusField.wrappedValue = .username
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @FocusState var focusField: StudentSignUpView.FocusField?

    UsernameInputView(
        signUpModel: StudentSignUpModel(socialLoginType: .apple),
        isSatisfiedCurrentInput: .constant(false),
        isDuplicatedUsername: .constant(.value(false)),
        focusField: $focusField
    )
}
