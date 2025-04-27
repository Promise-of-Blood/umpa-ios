// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct UsernameInputView: View {
    @ObservedObject var studentSignUpModel: StudentSignUpModel
    @Binding var isSatisfiedToNextStep: Bool

    @Binding var isDuplicatedUsername: Bool?

    @FocusState private var isUsernameFieldFocused: Bool

    // MARK: View

    var body: some View {
        content
            .onAppear {
                isUsernameFieldFocused = true
                isSatisfiedToNextStep = studentSignUpModel.validateUserName()
            }
            .onChange(of: studentSignUpModel.username) {
                isSatisfiedToNextStep = studentSignUpModel.validateUserName()
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
        .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)
    }

    var nicknameTextField: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundStyle(UmpaColor.lightGray)
            TextField(
                "닉네임",
                text: $studentSignUpModel.username,
                prompt: Text("닉네임을 입력해주세요")
            )
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
        studentSignUpModel: StudentSignUpModel(socialLoginType: .apple),
        isSatisfiedToNextStep: .constant(false),
        isDuplicatedUsername: .constant(false)
    )
}
