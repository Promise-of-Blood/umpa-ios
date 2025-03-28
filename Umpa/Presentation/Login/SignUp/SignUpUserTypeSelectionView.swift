// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct SignUpUserTypeSelectionView: View {
    @InjectedObject(\.signUpModel) private var signUpModel

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    var content: some View {
        VStack {
            Text("앱의 이용 목적에 따라\n선택해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                HStack {
                    Button(action: didTapStudentButton) {
                        Text("학생 회원")
                            .modifier(UserTypeSelectionButton(isSelected: signUpModel.userType == .student))
                    }
                    Button(action: didTapTeacherButton) {
                        Text("선생님 회원")
                            .modifier(UserTypeSelectionButton(isSelected: signUpModel.userType == .teacher))
                    }
                }
            }
            Spacer()
            NavigationLink {
                switch signUpModel.userType {
                case .student:
                    SignUpNicknameInputView()
                case .teacher:
                    SignUpNameInputView()
                }
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
    }

    func didTapStudentButton() {
        signUpModel.userType = .student
    }

    func didTapTeacherButton() {
        signUpModel.userType = .teacher
    }
}

private struct UserTypeSelectionButton: ViewModifier {
    let isSelected: Bool

    private let borderWidth: CGFloat = 1
    private let cornerRadius: CGFloat = 5
    private var innerCornerRadius: CGFloat { cornerRadius - borderWidth }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(isSelected ? Color.white : UmpaColor.main)
            .frame(width: 145 - borderWidth * 2, height: 50 - borderWidth * 2)
            .background(
                isSelected ? UmpaColor.main : Color.white,
                in: RoundedRectangle(cornerRadius: innerCornerRadius)
            )
            .padding(borderWidth)
            .background(
                UmpaColor.main,
                in: RoundedRectangle(cornerRadius: cornerRadius)
            )
    }
}

#Preview {
    NavigationStack {
        SignUpUserTypeSelectionView()
    }
}

#Preview(traits: .iPhoneSE) {
    NavigationStack {
        SignUpUserTypeSelectionView()
    }
}
