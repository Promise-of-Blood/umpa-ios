// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct UserTypeSelectionView: View {
    enum NavigationDestination {
        case studentSignUp
        case teacherSignUp
    }

    @EnvironmentObject private var preSignUpData: PreSignUpData

    @Injected(\.appState) private var appState

    @State private var showAlert = false

    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    DismissButton(.arrowBack)
                        .padding(.horizontal, SignUpConstant.backButtonPadding)
                }
            }
            .navigationDestination(for: NavigationDestination.self) {
                switch $0 {
                case .studentSignUp:
                    StudentSignUpView(socialLoginType: preSignUpData.socialLoginType!)
                case .teacherSignUp:
                    TeacherSignUpView(socialLoginType: preSignUpData.socialLoginType!)
                }
            }
            .alert("회원 유형을 선택해주세요", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            }
    }

    var content: some View {
        VStack {
            VStack(spacing: fs(40)) {
                Text("앱의 이용 목적에 따라 선택해주세요")
                    .font(SignUpConstant.titleFont)
                    .foregroundStyle(SignUpConstant.titleColor)
                    .padding(.top, SignUpConstant.titleTopPaddingWithoutProgressView)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: fs(20)) {
                    UserTypeCardButton(
                        userType: .student,
                        isSelected: preSignUpData.userType == .student,
                        action: {
                            preSignUpData.userType = .student
                        },
                    )
                    UserTypeCardButton(
                        userType: .teacher,
                        isSelected: preSignUpData.userType == .teacher,
                        action: {
                            preSignUpData.userType = .teacher
                        },
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, SignUpConstant.contentHorizontalPadding)

            Spacer()

            SignUpBottomButton {
                switch preSignUpData.userType {
                case .student:
                    UmpaLogger.log("학생 회원가입 화면으로 이동", level: .debug)
                    appState.routing.loginNavigationPath.append(NavigationDestination.studentSignUp)
                case .teacher:
                    UmpaLogger.log("선생님 회원가입 화면으로 이동", level: .debug)
                    appState.routing.loginNavigationPath.append(NavigationDestination.teacherSignUp)
                case .none:
                    UmpaLogger.log("회원 유형이 선택되지 않고 다음 버튼이 눌림", level: .error)
                    showAlert = true
                }
            } label: {
                Text("다음")
            }
            .disabled(preSignUpData.userType == nil)
        }
    }
}

private struct UserTypeCardButton: View {
    let userType: UserType
    let isSelected: Bool
    let action: () -> Void

    private var title: String {
        switch userType {
        case .student:
            return "학생 회원"
        case .teacher:
            return "선생님 회원"
        }
    }

    private var image: ImageResource {
        switch userType {
        case .student:
            return .studentUserSymbol
        case .teacher:
            return .teacherUserSymbol
        }
    }

    private let cornerRadius: CGFloat = fs(15)

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(0)) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: fs(16), leading: fs(6), bottom: fs(8), trailing: fs(6)))
                Text(title)
                    .font(.pretendardBold(size: fs(20)))
                    .foregroundStyle(isSelected ? .white : UmpaColor.darkGray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, fs(10))
                    .background(isSelected ? UmpaColor.mainBlue : UmpaColor.baseColor)
            }
        }
        .frame(maxWidth: fs(150))
        .background(isSelected ? UmpaColor.lightBlue : .white)
        .innerRoundedStroke(
            isSelected ? UmpaColor.mainBlue : UmpaColor.baseColor,
            cornerRadius: cornerRadius,
            lineWidth: fs(2)
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        UserTypeSelectionView()
            .environmentObject(PreSignUpData())
    }
}

#Preview(traits: .iPhoneSE) {
    NavigationStack {
        UserTypeSelectionView()
            .environmentObject(PreSignUpData())
    }
}
