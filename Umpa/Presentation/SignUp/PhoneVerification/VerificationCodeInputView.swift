// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct VerificationCodeInputView: View {
    enum NavigationDestination {
        case acceptTerms
    }

    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var preSignUpData: PreSignUpData

    #if DEBUG
    @Injected(\.mockPhoneVerificationInteractor)
    #else
    @Injected(\.phoneVerificationInteractor)
    #endif
    private var interactor: PhoneVerificationInteractor

    /// 인증번호
    @State private var verificationCode: String = ""

    /// 인증번호 확인 상태
    @State private var isVerifiedCode: ValueLoadable<Bool?> = .value(nil)

    /// 인증 코드 만료 시각
    @State private var expirationTime = Date.now.addingTimeInterval(TimeInterval(SignUpConstant.verificationCodeExpirationTime))

    @State private var error: PhoneVerificationError?
    @State private var isExpired = false
    @State private var isResendingVerificationCode = false

    @FocusState private var isFocusedCodeTextField: Bool

    private let cornerRadius: CGFloat = fs(10)

    let rawPhoneNumber: String

    var body: some View {
        content
            .errorAlert($error)
            .onAppear {
                isFocusedCodeTextField = true
                preSignUpData.userType = nil
            }
            .navigationDestination(for: NavigationDestination.self) {
                switch $0 {
                case .acceptTerms:
                    AcceptTermsView()
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(.arrowBack)
                            .padding(.horizontal, SignUpConstant.backButtonPadding)
                    }
                }
            }
    }

    @ViewBuilder
    var content: some View {
        VStack {
            VStack(spacing: fs(40)) {
                TitleText("문자로 받은 인증번호를 입력해주세요")
                    .padding(.top, SignUpConstant.titleTopPaddingWithoutProgressView)
                verificationSection
            }
            .padding(.horizontal, SignUpConstant.contentHorizontalPadding)
            
            Spacer()
            
            SignUpBottomButton {
                interactor.verifyCodeAndMoveToNext(verificationCode, isVerifiedCode: $isVerifiedCode)
            } label: {
                if isVerifiedCode.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Text("인증번호 확인")
                }
            }
            .disabled(!PhoneVerificationCodeValidator(rawCode: verificationCode).validate() ||
                      isExpired ||
                      isVerifiedCode.isLoading ||
                      isVerifiedCode.value == false)
        }
        .background(.white)
    }

    var verificationSection: some View {
        VStack(spacing: fs(20)) {
            VStack(alignment: .leading, spacing: fs(8)) {
                verificationCodeTextField
                invalidVerificationCodeText
            }
            resendVerificationCodeButton
        }
        .frame(maxWidth: .infinity)
    }

    var resendVerificationCodeButton: some View {
        Button(action: {
            interactor.resendVerificationCode(
                with: rawPhoneNumber,
                verificationCode: $verificationCode,
                expirationTime: $expirationTime,
                isExpired: $isExpired,
                isResendingVerificationCode: $isResendingVerificationCode,
                isVerifiedCode: $isVerifiedCode,
                e: $error,
            )
        }) {
            if isResendingVerificationCode {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Text("인증번호 재발송")
                    .font(.pretendardRegular(size: fs(14)))
            }
        }
    }

    var verificationCodeTextField: some View {
        HStack(spacing: fs(8)) {
            TextField(
                text: $verificationCode,
                prompt: Text("인증번호 입력"),
                label: {
                    Text("인증번호 입력")
                }
            )
            .foregroundStyle(.black)
            .keyboardType(.numberPad)
            .onChange(of: verificationCode) { _, newValue in
                isVerifiedCode.value = nil
                let digits = newValue.filter { $0.isNumber }
                let maxVerificationCodeLength = 6
                verificationCode = String(digits.prefix(maxVerificationCodeLength))
            }
            .focused($isFocusedCodeTextField)

            CountdownText(endDate: $expirationTime, isExpired: $isExpired)
        }
        .padding(.horizontal, fs(14))
        .padding(.vertical, fs(18))
        .background(.white)
        .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: cornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    var invalidVerificationCodeText: some View {
        Text("인증번호를 다시 확인해주세요")
            .font(.pretendardRegular(size: fs(13)))
            .foregroundStyle(.red)
            .padding(.horizontal, fs(2))
            .opacity(isVerifiedCode.value == false ? 1 : 0)
    }
}

private struct CountdownText: View {
    /// 타이머가 끝나는 절대 시각
    @Binding var endDate: Date

    @Binding var isExpired: Bool

    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1)) { context in
            let remaining = max(0, Int(endDate.timeIntervalSince(context.date)))
            Text(remaining.mmSS)
                .font(.pretendardRegular(size: fs(15)))
                .foregroundColor(remaining == 0 ? .red : UmpaColor.mainBlue)
                .monospacedDigit()
                .onChange(of: remaining) { _, newValue in
                    if newValue == 0 { isExpired = true }
                }
        }
    }
}

private extension Int {
    /// 185 → "03:05" 형식
    var mmSS: String { String(format: "%02d:%02d", self / 60, self % 60) }
}

#Preview {
    NavigationStack {
        VerificationCodeInputView(rawPhoneNumber: "01012341234")
    }
}
