// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

struct StudentSignUpView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var studentSignUpModel: StudentSignUpModel

    /// 회원가입 진행 상태를 나타내는 index. TabView의 selection과 연결되어 화면 전환을 관리
    @State private var currentSignUpOrderIndex = 0

    /// 진행바를 표시하기 위한 진행률 값
    @State private var signUpProgressValue: CGFloat = StudentSignUpProgress.allCases[0].progressValue

    /// 다음 버튼 활성화 여부
    @State private var isSatisfiedToNextStep = false

    /// 닉네임이 중복인지 여부
    @State private var isDuplicatedUsername: ValueLoadable<Bool?> = .value(nil)

    /// 닉네임 확인 알림
    @State private var isShowingUsernameAlert = false

    /// 건너뛰기 확인 알림
    @State private var isShowingSkipAlert: Bool = false

    #if DEBUG
    @Injected(\.mockStudentSignUpInteractor)
    #endif
    private var interactor

    private var signUpOrderLastIndex: Int {
        StudentSignUpProgress.allCases.endIndex - 1
    }

    /// 현재 진행 중인 회원가입 단계를 나타내는 enum 값
    private var currentSignUpProgress: StudentSignUpProgress {
        StudentSignUpProgress.allCases[currentSignUpOrderIndex]
    }

    private var isDisabledNextButton: Bool {
        !isSatisfiedToNextStep || isDuplicatedUsername.isLoading || isDuplicatedUsername.value == true
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
                    UmpaLogger(category: .signUp).log("추가 프로필 입력 건너뜀 : \(studentSignUpModel.debugDescription)")
                    interactor.completeSignUp(with: studentSignUpModel)
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
        .opacity(currentSignUpProgress.isRequired ? 0 : 1)
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
            bottomNextButton
        }
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
            Text(currentSignUpOrderIndex < signUpOrderLastIndex ? "다음" : "완료")
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
                            Array(zip(signUpInputEntry(), StudentSignUpProgress.allCases)),
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
            UsernameInputView(
                studentSignUpModel: studentSignUpModel,
                isSatisfiedToNextStep: $isSatisfiedToNextStep,
                isDuplicatedUsername: $isDuplicatedUsername,
            ),
            MajorSelectionView(
                signUpModel: studentSignUpModel,
                isSatisfiedToNextStep: $isSatisfiedToNextStep,
            ),
            DreamCollegesSelectionView(
                studentSignUpModel: studentSignUpModel,
                isSatisfiedToNextStep: $isSatisfiedToNextStep,
            ),
            StudentProfileInputView(signUpModel: studentSignUpModel),
            EmptyView(), // .preferSubjectSelection
            EmptyView(), // .lessonRequirement
        ]
        assert(entry.count == StudentSignUpProgress.allCases.count, "진행도에 따른 화면을 추가해야 합니다.")
        return entry
    }

    // MARK: Private Methods

    private func moveToNextProgress() {
        assert(currentSignUpOrderIndex < signUpOrderLastIndex)
        currentSignUpOrderIndex += 1

        // 필수 입력 단계가 아니거나 입력이 유효한 경우 다음 버튼을 활성화한다.
        isSatisfiedToNextStep = !currentSignUpProgress.isRequired || validateInput(of: currentSignUpProgress)

        signUpProgressValue = currentSignUpProgress.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpProgress), \(studentSignUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func validateInput(of signUpProgress: StudentSignUpProgress) -> Bool {
        switch signUpProgress {
        case .usernameInput:
            return studentSignUpModel.validateUserName()
        case .majorSelection:
            return studentSignUpModel.validateMajor()
        case .dreamCollegeSelection:
            return studentSignUpModel.validateDreamColleges()
        // 해당 단계의 항목들은 필수 입력이 아니므로 true반환
        case .profileInput, .preferSubjectSelection, .lessonRequirement:
            return true
        }
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
        signUpProgressValue = currentSignUpProgress.progressValue

        #if DEBUG
        UmpaLogger(category: .signUp).log(
            "현재 회원가입 진행: \(currentSignUpProgress), \(studentSignUpModel.debugDescription)",
            level: .debug
        )
        #endif
    }

    private func didTapBottomButton() {
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
