// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

enum TeacherSignUpProgress: Int, CaseIterable {
    case majorSelection = 0
    case profileInput
    case experienceInput
    case linkInput

    var progressValue: Double {
        let minProgress = 0.2
        let maxProgress = 0.85
        let steps = Double(Self.allCases.count - 1)
        // rawValue 0 → minProgress, rawValue == steps → maxProgress
        return minProgress + (Double(rawValue) / steps) * (maxProgress - minProgress)
    }
}

struct TeacherSignUpView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var signUpModel: TeacherSignUpModel
    @State private var currentSignUpOrderIndex = 0
    @State private var signUpProgressValue = TeacherSignUpProgress.allCases[0].progressValue
    @State private var isSatisfiedToNextStep = false

    #if DEBUG
    @Injected(\.mockTeacherSignUpInteractor)
    #endif
    private var interactor

    private var signUpOrderLastIndex: Int {
        TeacherSignUpProgress.allCases.endIndex - 1
    }

    init(socialLoginType: SocialLoginType) {
        self._signUpModel = StateObject(wrappedValue: TeacherSignUpModel(socialLoginType: socialLoginType))
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
            ForEach(TeacherSignUpProgress.allCases, id: \.rawValue) { progress in
                switch progress {
                case .majorSelection:
                    VStack {
                        MajorSelectionView(
                            signUpModel: signUpModel,
                            isSatisfiedToNextStep: $isSatisfiedToNextStep
                        )
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .profileInput:
                    VStack {
                        EmptyView()
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .experienceInput:
                    VStack {
                        EmptyView()
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                case .linkInput:
                    VStack {
                        EmptyView()
                        Spacer(minLength: 0)
                    }
                    .tag(progress)
                }
            }
        }
        .padding(.top, SignUpSharedUIConstant.titleTopPaddingWithProgressView)
    }

    // MARK: Private Methods

    private func didTapBackButton() {
        if currentSignUpOrderIndex > 0 {
            moveToPreviousProgress()
        } else {
            dismiss()
        }
    }

    private func moveToNextProgress() {
        assert(currentSignUpOrderIndex < signUpOrderLastIndex)
        isSatisfiedToNextStep = true
        currentSignUpOrderIndex += 1
        signUpProgressValue = TeacherSignUpProgress.allCases[currentSignUpOrderIndex].progressValue

        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(TeacherSignUpProgress.allCases[currentSignUpOrderIndex]), \(signUpModel.debugDescription)",
            level: .debug
        )
    }

    private func moveToPreviousProgress() {
        assert(currentSignUpOrderIndex > 0)
        // 전 단계는 이미 만족했으므로 true로 설정
        isSatisfiedToNextStep = true
        currentSignUpOrderIndex -= 1
        signUpProgressValue = TeacherSignUpProgress.allCases[currentSignUpOrderIndex].progressValue

        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(TeacherSignUpProgress.allCases[currentSignUpOrderIndex]), \(signUpModel.debugDescription)",
            level: .debug
        )
    }

    private func didTapBottomButton() {
        let currentSignUpProgress = TeacherSignUpProgress.allCases[currentSignUpOrderIndex]
        switch currentSignUpProgress {
        case .majorSelection, .profileInput, .experienceInput:
            moveToNextProgress()
        case .linkInput:
            interactor.completeSignUp(with: signUpModel)
        }
    }
}

#Preview {
    TeacherSignUpView(socialLoginType: .apple)
}
