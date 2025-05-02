// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct StudentSignUpView: View {
    enum FocusField {
        case username
        case lessonRequirements
    }

    @Environment(\.dismiss) private var dismiss

    #if DEBUG
    @Injected(\.mockStudentSignUpInteractor)
    #endif
    private var interactor

    @StateObject private var signUpModel: StudentSignUpModel

    /// 진행바를 표시하기 위한 진행률 값
    @State private var signUpProgressValue: CGFloat = StudentSignUpStep.first.progressValue

    /// 현재 보이는 화면의 입력이 유효한지 여부
    @State private var isSatisfiedCurrentInput = false

    /// 닉네임이 중복인지 여부
    @State private var isDuplicatedUsername: ValueLoadable<Bool?> = .value(nil)

    /// 닉네임 확인 알림
    @State private var isShowingUsernameAlert = false

    /// 건너뛰기 확인 알림
    @State private var isShowingSkipAlert: Bool = false

    /// 현재 진행 중인 회원가입 단계를 나타내는 enum 값
    @State private var currentSignUpStep: StudentSignUpStep = .first

    @FocusState private var focusField: FocusField?

    // 다음 버튼 활성화/비활성화 여부
    private var isDisabledNextButton: Bool {
        !isSatisfiedCurrentInput || isDuplicatedUsername.isLoading || isDuplicatedUsername.value == true
    }

    init(socialLoginType: SocialLoginType) {
        self._signUpModel = StateObject(wrappedValue: StudentSignUpModel(socialLoginType: socialLoginType))
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
            .alert("닉네임 확인", isPresented: $isShowingUsernameAlert) {
                Button("아니오", action: {})
                Button("네", action: moveToNextProgress)
            } message: {
                Text("이 닉네임으로 사용하시겠습니까?")
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
            bottomNextButton
        }
        .background(.white)
    }

    var bottomNextButton: some View {
        SignUpBottomButton(action: didTapBottomButton) {
            bottomNextButtonLabel
        }
        .disabled(isDisabledNextButton)
    }

    @ViewBuilder
    var bottomNextButtonLabel: some View {
        switch isDuplicatedUsername {
        case .value:
            Text(currentSignUpStep < .last ? "다음" : "완료")
        case .isLoading:
            ProgressView()
                .progressViewStyle(.circular)
        }
    }

    var signUpInputView: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(
                            Array(zip(signUpInputEntry(), StudentSignUpStep.allCases)),
                            id: \.1.rawValue
                        ) { inputView, progress in
                            AnyView(inputView)
                                .padding(.horizontal, SignUpConstant.contentHorizontalPadding)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                                .id(progress)
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
            UsernameInputView(
                signUpModel: signUpModel,
                isSatisfiedCurrentInput: $isSatisfiedCurrentInput,
                isDuplicatedUsername: $isDuplicatedUsername,
                focusField: $focusField,
            ),
            MajorSelectionView(
                signUpModel: signUpModel,
                isSatisfiedCurrentInput: $isSatisfiedCurrentInput,
            ),
            DreamCollegesSelectionView(
                signUpModel: signUpModel,
                isSatisfiedCurrentInput: $isSatisfiedCurrentInput,
            ),
            StudentProfileInputView(signUpModel: signUpModel),
            PreferSubjectSelectionView(signUpModel: signUpModel),
            LessonRequirementView(signUpModel: signUpModel, focusField: $focusField),
        ]
        assert(entry.count == StudentSignUpStep.allCases.count, "진행도에 따른 화면을 추가해야 합니다.")
        return entry
    }

    // MARK: Private Methods

    private func moveToNextProgress() {
        assert(currentSignUpStep < .last)
        currentSignUpStep.next()

        // 필수 입력 단계가 아니거나 입력이 유효한 경우 다음 버튼을 활성화한다.
        isSatisfiedCurrentInput = currentSignUpStep.canSkip || validateInput(of: currentSignUpStep)

        signUpProgressValue = currentSignUpStep.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpStep.debugDescription), \(signUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func validateInput(of signUpStep: StudentSignUpStep) -> Bool {
        switch signUpStep {
        case .usernameInput:
            return signUpModel.validateUserName()
        case .majorSelection:
            return signUpModel.validateMajor()
        case .dreamCollegeSelection:
            return signUpModel.validateDreamColleges()
        // 해당 단계의 항목들은 필수 입력이 아니므로 true반환
        case .profileInput, .preferSubjectSelection, .lessonRequirement:
            return true
        }
    }

    private func didTapBackButton() {
        focusField = nil
        if currentSignUpStep > .first {
            moveToPreviousProgress()
        } else {
            dismiss()
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
        focusField = nil
        switch currentSignUpStep {
        case .usernameInput:
            interactor.performDuplicateCheck(
                username: signUpModel.username,
                isShowingUsernameAlert: $isShowingUsernameAlert,
                isDuplicatedUsername: $isDuplicatedUsername,
            )
        case .majorSelection, .dreamCollegeSelection, .profileInput, .preferSubjectSelection:
            moveToNextProgress()
        case .lessonRequirement:
            interactor.signUp(with: signUpModel)
        }
    }
}

#Preview {
    NavigationStack {
        StudentSignUpView(socialLoginType: .apple)
    }
}
