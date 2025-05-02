// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct TeacherSignUpView: View {
    @Environment(\.dismiss) private var dismiss

    #if DEBUG
    @Injected(\.mockTeacherSignUpInteractor)
    #endif
    private var interactor

    @StateObject private var signUpModel: TeacherSignUpModel
    @State private var signUpProgressValue = TeacherSignUpStep.first.progressValue

    /// 현재 보이는 화면의 입력이 유효한지 여부
    @State private var isSatisfiedCurrentInput = false

    @State private var currentSignUpStep: TeacherSignUpStep = .first

    /// 건너뛰기 확인 알림
    @State private var isShowingSkipAlert: Bool = false

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
                            .padding(.horizontal, SignUpConstant.backButtonPadding)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    signUpSkipButton
                }
            }
            .alert("프로필 입력 건너뛰기 확인", isPresented: $isShowingSkipAlert) {
                Button("아니오", action: {})
                Button("네", action: {
                    UmpaLogger(category: .signUp).log("추가 프로필 입력 건너뜀 : \(signUpModel.debugDescription)")
                    interactor.signUp(with: signUpModel)
                })
            } message: {
                Text("프로필 입력을 생략하고 홈화면으로 이동하시겠습니까?")
            }
    }

    var signUpSkipButton: some View {
        Button(action: {
            isShowingSkipAlert = true
        }) {
            Text("건너 뛰기")
                .font(.pretendardRegular(size: fs(16)))
                .foregroundStyle(UmpaColor.mainBlue)
        }
        .opacity(currentSignUpStep.canSkip ? 1 : 0)
    }

    var content: some View {
        VStack {
            ProgressView(value: signUpProgressValue)
                .background(UmpaColor.lightBlue)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .padding(.horizontal, SignUpConstant.contentHorizontalPadding)
                .padding(.top, SignUpConstant.progressViewTopPadding)
                .animation(.easeInOut, value: signUpProgressValue)

            signUpInputView

            SignUpBottomButton(action: didTapBottomButton) {
                Text(currentSignUpStep < TeacherSignUpStep.last ? "다음" : "완료")
            }
            .disabled(!isSatisfiedCurrentInput)
        }
        .background(.white)
    }

    var signUpInputView: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(
                            Array(zip(signUpInputEntry(), TeacherSignUpStep.allCases)),
                            id: \.1.rawValue
                        ) { inputView, step in
                            AnyView(inputView)
                                .padding(.horizontal, SignUpConstant.contentHorizontalPadding)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                                .id(step)
                        }
                    }
                }
                .scrollDisabled(true)
                .onChange(of: currentSignUpStep) { _, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .leading)
                    }
                }
            }
            .padding(.top, SignUpConstant.titleTopPaddingWithProgressView)
        }
    }

    func signUpInputEntry() -> [any View] {
        let entry: [any View] = [
            MajorSelectionView(
                signUpModel: signUpModel,
                isSatisfiedCurrentInput: $isSatisfiedCurrentInput,
            ),
            TeacherProfileInputView(
                signUpModel: signUpModel,
                isSatisfiedCurrentInput: $isSatisfiedCurrentInput,
            ),
            ExperienceInputView(signUpModel: signUpModel),
            LinkInputView(signUpModel: signUpModel),
        ]
        assert(entry.count == TeacherSignUpStep.allCases.count, "진행도에 따른 화면을 추가해야 합니다.")
        return entry
    }

    // MARK: Private Methods

    private func didTapBackButton() {
        if currentSignUpStep > .first {
            moveToPreviousProgress()
        } else {
            dismiss()
        }
    }

    private func moveToNextProgress() {
        assert(currentSignUpStep < .last)
        currentSignUpStep.next()
        isSatisfiedCurrentInput = validateInput(of: currentSignUpStep)
        signUpProgressValue = currentSignUpStep.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpStep.debugDescription), \(signUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func validateInput(of signUpStep: TeacherSignUpStep) -> Bool {
        switch signUpStep {
        case .majorSelection:
            return signUpModel.validateMajor()
        case .profileInput:
            return signUpModel.validateGender() && signUpModel.validateLessonRegion()
        case .experienceInput, .linkInput:
            return true
        }
    }

    private func moveToPreviousProgress() {
        assert(currentSignUpStep > .first)
        // 전 단계는 이미 만족했으므로 true로 설정
        isSatisfiedCurrentInput = true
        currentSignUpStep.previous()
        signUpProgressValue = currentSignUpStep.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpStep.debugDescription), \(signUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func didTapBottomButton() {
        switch currentSignUpStep {
        case .majorSelection, .profileInput, .experienceInput:
            moveToNextProgress()
        case .linkInput:
            interactor.signUp(with: signUpModel)
        }
    }
}

#Preview {
    NavigationStack {
        TeacherSignUpView(socialLoginType: .apple)
    }
}
