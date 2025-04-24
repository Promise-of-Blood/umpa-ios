// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct UsernameInputView: View {
    @StateObject private var studentSignUpModel: StudentSignUpModel

    @FocusState private var isFocused: Bool

    init(socialLoginType: SocialLoginType) {
        _studentSignUpModel = StateObject(wrappedValue: StudentSignUpModel(socialLoginType: socialLoginType))
    }

    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    DismissButton(.arrowBack)
                        .padding(.horizontal, SignUpSharedUIConstant.backButtonPadding)
                }
            }
//            .navigationDestination(for: <#T##Hashable.Type#>) { <#Hashable#> in
//                <#code#>
//            }
    }

    var content: some View {
        VStack {
            Text("닉네임을 입력해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                InputFieldLabelText("닉네임")
                nicknameTextField
            }
            Spacer()
//            NavigationLink {
//                TeacherMajorSelectionView(signUpModel: signUpModel)
//            } label: {
//                Text("다음")
//                    .modifier(BottomButton())
//            }
        }
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
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    NavigationStack {
//        UsernameInputView(signUpModel: SignUpModel(socialLoginType: .apple))
    }
}
