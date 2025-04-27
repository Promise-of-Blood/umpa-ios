// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

enum StudentSignUpProgress: Int, CaseIterable {
    case usernameInput = 0
    case majorSelection
    case dreamCollegeSelection
    case profileInput
    case preferSubjectSelection
    case lessonRequirement

    var progressValue: Double {
        let minProgress = 0.16
        let maxProgress = 0.9
        let steps = Double(Self.allCases.count - 1)
        // rawValue 0 → minProgress, rawValue == steps → maxProgress
        return minProgress + (Double(rawValue) / steps) * (maxProgress - minProgress)
    }
}

struct StudentSignUpView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var studentSignUpModel: StudentSignUpModel
    @State private var currentSignUpOrderIndex = 0
    @State private var signUpProgressValue = StudentSignUpProgress.allCases[0].progressValue
    @State private var isSatisfiedToNextStep = false
    @State private var isShowingUsernameAlert = false
    @State private var isDuplicatedUsername: Bool?

    #if DEBUG
    @Injected(\.mockStudentSignUpInteractor)
    #endif
    private var interactor

    private var signUpOrderLastIndex: Int {
        StudentSignUpProgress.allCases.endIndex - 1
    }

    init(socialLoginType: SocialLoginType) {
        self._studentSignUpModel = StateObject(wrappedValue: StudentSignUpModel(socialLoginType: socialLoginType))
    }

    // MARK: View

    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: didTapBackButton) {
                        Image(.arrowBack)
                            .padding(.horizontal, SignUpSharedUIConstant.backButtonPadding)
                    }
                }
            }
            .alert("닉네임 확인", isPresented: $isShowingUsernameAlert) {
                Button("아니오", action: {})
                Button("네", action: moveToNextProgress)
            } message: {
                Text("이 닉네임으로 사용하시겠습니까?")
            }
    }

    var content: some View {
        VStack {
            ProgressView(value: signUpProgressValue)
                .background(UmpaColor.lightBlue)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)
                .padding(.top, SignUpSharedUIConstant.progressViewTopPadding)
                .animation(.easeInOut, value: signUpProgressValue)

            signUpInputView

            SignUpBottomButton(action: didTapBottomButton) {
                Text(currentSignUpOrderIndex < signUpOrderLastIndex ? "다음" : "완료")
            }
            .disabled(!isSatisfiedToNextStep)
        }
    }

    var signUpInputView: some View {
        TabView(selection: $currentSignUpOrderIndex) {
            ForEach(StudentSignUpProgress.allCases, id: \.rawValue) { progress in
                switch progress {
                case .usernameInput:
                    VStack {
                        UsernameInputView(
                            studentSignUpModel: studentSignUpModel,
                            isSatisfiedToNextStep: $isSatisfiedToNextStep,
                            isDuplicatedUsername: $isDuplicatedUsername,
                        )
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .majorSelection:
                    VStack {
                        MajorSelectionView(
                            signUpModel: studentSignUpModel,
                            isSatisfiedToNextStep: $isSatisfiedToNextStep,
                        )
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .dreamCollegeSelection:
                    VStack {
                        DreamCollegesSelectionView(
                            studentSignUpModel: studentSignUpModel,
                            isSatisfiedToNextStep: $isSatisfiedToNextStep,
                        )
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .profileInput:
                    EmptyView()
//                                ProfileInputView()
                        .tag(progress)
                case .preferSubjectSelection:
                    EmptyView()
//                                PreferSubjectSelectionView()
                        .tag(progress)
                case .lessonRequirement:
                    EmptyView()
//                                LessonRequirementView()
                        .tag(progress)
                }
            }
        }
        .padding(.top, SignUpSharedUIConstant.titleTopPaddingWithProgressView)
    }

    // MARK: Private Methods

    private func moveToNextProgress() {
        assert(currentSignUpOrderIndex < signUpOrderLastIndex)
        isSatisfiedToNextStep = false
        currentSignUpOrderIndex += 1
        signUpProgressValue = StudentSignUpProgress.allCases[currentSignUpOrderIndex].progressValue

        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(StudentSignUpProgress.allCases[currentSignUpOrderIndex]), \(studentSignUpModel.debugDescription)",
            level: .debug
        )
    }

    private func didTapBackButton() {
        if currentSignUpOrderIndex > 0 {
            moveToPreviousProgress()
        } else {
            dismiss()
        }
    }

    private func moveToPreviousProgress() {
        assert(currentSignUpOrderIndex > 0)
        // 전 단계는 이미 만족했으므로 true로 설정
        isSatisfiedToNextStep = true
        currentSignUpOrderIndex -= 1
        signUpProgressValue = StudentSignUpProgress.allCases[currentSignUpOrderIndex].progressValue

        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(StudentSignUpProgress.allCases[currentSignUpOrderIndex]), \(studentSignUpModel.debugDescription)",
            level: .debug
        )
    }

    private func didTapBottomButton() {
        let currentSignUpProgress = StudentSignUpProgress.allCases[currentSignUpOrderIndex]
        switch currentSignUpProgress {
        case .usernameInput:
            interactor.performDuplicateCheck(
                username: studentSignUpModel.username,
                isShowingUsernameAlert: $isShowingUsernameAlert,
                isDuplicatedUsername: $isDuplicatedUsername,
            )
        case .majorSelection, .dreamCollegeSelection, .profileInput, .preferSubjectSelection:
            moveToNextProgress()
        case .lessonRequirement:
            interactor.completeSignUp(with: studentSignUpModel)
        }
    }
}

#Preview {
    NavigationStack {
        StudentSignUpView(socialLoginType: .apple)
    }
}
