// Created for Umpa in 2025

import SwiftUI

enum UserType {
    case student
    case teacher
}

struct SignUpUserTypeSelectionView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var userType: UserType = .student

    var body: some View {
        VStack {
            Text("앱의 이용 목적에 따라\n선택해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                HStack {
                    Button(action: didTapStudentButton) {
                        Text("학생 회원")
                            .modifier(UserTypeSelectionButton(isSelected: userType == .student))
                    }
                    Button(action: didTapTeacherButton) {
                        Text("선생님 회원")
                            .modifier(UserTypeSelectionButton(isSelected: userType == .teacher))
                    }
                }
            }
            Spacer()
            NavigationLink {
                switch userType {
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
        .modifier(BackButton())
    }

    func didTapStudentButton() {
        userType = .student
    }

    func didTapTeacherButton() {
        userType = .teacher
    }
}

private struct UserTypeSelectionButton: ViewModifier {
    let isSelected: Bool

    private let borderWidth: CGFloat = 1
    private let cornerRadius: CGFloat = 5
    private var innerCornerRadius: CGFloat { cornerRadius - borderWidth }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(isSelected ? Color.white : Color.main)
            .frame(width: 145 - borderWidth * 2, height: 50 - borderWidth * 2)
            .background(
                isSelected ? Color.main : Color.white,
                in: RoundedRectangle(cornerRadius: innerCornerRadius)
            )
            .padding(borderWidth)
            .background(
                Color.main,
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
