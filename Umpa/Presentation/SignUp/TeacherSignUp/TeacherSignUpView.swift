// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

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

    /// 현재 진행 중인 회원가입 단계를 나타내는 enum 값
    private var currentSignUpProgress: TeacherSignUpProgress {
        TeacherSignUpProgress.allCases[currentSignUpOrderIndex]
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
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(
                            Array(zip(signUpInputEntry(), TeacherSignUpProgress.allCases)),
                            id: \.1.rawValue
                        ) { inputView, progress in
                            AnyView(inputView)
                                .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                                .id(progress)
                        }
                    }
                }
                .scrollDisabled(true)
                .onChange(of: currentSignUpProgress) { _, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .leading)
                    }
                }
            }
            .padding(.top, SignUpSharedUIConstant.titleTopPaddingWithProgressView)
        }
    }

    func signUpInputEntry() -> [any View] {
        let entry: [any View] = [
            MajorSelectionView(
                signUpModel: signUpModel,
                isSatisfiedToNextStep: $isSatisfiedToNextStep,
            ),
            TeacherProfileInputView(
                signUpModel: signUpModel,
                isSatisfiedToNextStep: $isSatisfiedToNextStep,
            ),
            ExperienceInputView(signUpModel: signUpModel),
            LinkInputView(signUpModel: signUpModel),
        ]
        assert(entry.count == TeacherSignUpProgress.allCases.count, "진행도에 따른 화면을 추가해야 합니다.")
        return entry
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
        currentSignUpOrderIndex += 1
        isSatisfiedToNextStep = validateInput(of: currentSignUpProgress)
        signUpProgressValue = currentSignUpProgress.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpProgress), \(signUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func validateInput(of signUpProgress: TeacherSignUpProgress) -> Bool {
        switch signUpProgress {
        case .majorSelection:
            return signUpModel.validateMajor()
        case .profileInput:
            return signUpModel.validateGender() && signUpModel.validateLessonRegion()
        case .experienceInput, .linkInput:
            return true
        }
    }

    private func moveToPreviousProgress() {
        assert(currentSignUpOrderIndex > 0)
        // 전 단계는 이미 만족했으므로 true로 설정
        isSatisfiedToNextStep = true
        currentSignUpOrderIndex -= 1
        signUpProgressValue = currentSignUpProgress.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpProgress), \(signUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func didTapBottomButton() {
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
