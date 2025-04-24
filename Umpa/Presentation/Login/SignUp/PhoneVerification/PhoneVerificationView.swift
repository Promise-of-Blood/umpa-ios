// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct PhoneVerificationView: View {
    enum FocusField: Hashable {
        case phoneNumber
        case verificationCode
    }

    /// 하이픈(-)을 제외한 실제 전화번호 문자열 (01012345678)
    @State private var rawPhoneNumber: String = ""

    /// 텍스트필드에 표시될 전화번호 문자열 (010-1234-5678)
    @State private var formattedPhoneNumber: String = ""

    /// 인증번호 발송 상태
    @State private var isSentVerificationCode: ValueLoadable<Bool> = .value(false)

    /// 인증번호 문자열
    @State private var verificationCode: String = ""

    /// 인증번호 확인 상태
    @State private var isVarifiedCode: ValueLoadable<Bool?> = .value(nil)

    /// 인증 코드 만료 시각
    @State private var expirationTime = Date()

    @State private var isExpired = false

    @State private var error: PhoneVerificationError?

    @FocusState private var focusField: FocusField?

    #if DEBUG
    @Injected(\.mockPhoneVerificationInteractor)
    #else
    @Injected(\.phoneVerificationInteractor)
    #endif
    private var interactor: PhoneVerificationInteractor

    private let sharedCornerRadius: CGFloat = fs(10)

    /// 인증 코드를 보낸 직후부터 `true`를 반환합니다.
    private var isJustSentVerificationCode: Bool {
        return isSentVerificationCode.value || isSentVerificationCode.isLoading
    }

    // MARK: View

    var body: some View {
        content
            .errorAlert($error)
            .onAppear {
                focusField = .phoneNumber
            }
            .navigationDestination(for: SignUpRoute.self) { route in
                if case .acceptTerms = route {
                    // AcceptTermsView()
                }
            }
    }

    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: fs(60)) {
            header
            verificationSection
        }
        .frame(maxWidth: .infinity)
        .padding(.top, SignUpSharedUIConstant.titleTopPadding)
        .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)

        Spacer()

        SignUpBottomButton {
            interactor.verifyCodeToNext(verificationCode, isVarifiedCode: $isVarifiedCode)
        } label: {
            bottomButtonLabel
        }
        .disabled(!PhoneVerificationCodeValidator(rawCode: verificationCode).validate() ||
            isExpired ||
            isVarifiedCode.isLoading)
    }

    @ViewBuilder
    var bottomButtonLabel: some View {
        switch isVarifiedCode {
        case .value:
            Text("다음")
        case .isLoading:
            ProgressView()
                .progressViewStyle(.circular)
        }
    }

    var header: some View {
        VStack(alignment: .leading, spacing: fs(24)) {
            Text("전화번호를 입력해주세요")
                .font(.pretendardSemiBold(size: fs(24)))
                .foregroundStyle(UmpaColor.darkBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("음파 서비스를 이용하기 위해서 휴대전화번호 인증이 필요합니다. 번호는 외부에 노출되지 않습니다.")
                .font(.pretendardRegular(size: fs(13)))
                .foregroundStyle(UmpaColor.mediumGray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
    }

    var verificationSection: some View {
        VStack(alignment: .trailing, spacing: fs(18)) {
            phoneNumberTextField
            requestVerificationCodeButton
            VStack(alignment: .leading, spacing: fs(6)) {
                verificationCodeTextField
                invalidVerificationCodeText
            }
        }
        .frame(maxWidth: .infinity)
    }

    var phoneNumberTextField: some View {
        TextField(
            text: $formattedPhoneNumber,
            prompt: Text("휴대폰 번호 입력"),
            label: { Text("휴대폰 번호 입력") }
        )
        .padding(.horizontal, fs(16))
        .padding(.vertical, fs(18))
        .foregroundStyle(!isJustSentVerificationCode ? .black : .black.opacity(0.6))
        .background(!isJustSentVerificationCode ? .white : .gray.opacity(0.2))
        .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: sharedCornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: sharedCornerRadius))
        .keyboardType(.phonePad)
        .autocorrectionDisabled()
        .onChange(of: formattedPhoneNumber) { _, newValue in
            let digits = newValue.filter { $0.isNumber }
            // 최대 11자리까지만 허용
            let phoneNumber = String(digits.prefix(11))
            rawPhoneNumber = phoneNumber
            formattedPhoneNumber = formattedPhoneNumberInput(phoneNumber)
        }
        .focused($focusField, equals: .phoneNumber)
        .disabled(isJustSentVerificationCode)
    }

    var requestVerificationCodeButton: some View {
        Button(action: didTapRequestVerificationCodeButton) {
            requestVerificationCodeButtonLabel
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(!isJustSentVerificationCode ? .white : Color(hex: "003BDE"))
                .frame(width: 160, height: 50)
                .background(
                    !isJustSentVerificationCode ? UmpaColor.mainBlue : Color(hex: "D6E1FF"),
                    in: RoundedRectangle(cornerRadius: sharedCornerRadius)
                )
        }
        .buttonStyle(.borderless)
        .disabled(!PhoneNumberValidator(rawPhoneNumber: rawPhoneNumber).validate() ||
            isSentVerificationCode.isLoading)
    }

    @ViewBuilder
    var requestVerificationCodeButtonLabel: some View {
        switch isSentVerificationCode {
        case .value(let isSentVerificationCode):
            Text(!isSentVerificationCode ? "인증 요청" : "인증번호 재발송")
        case .isLoading:
            ProgressView()
                .progressViewStyle(.circular)
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
            .keyboardType(.phonePad)
            .onChange(of: verificationCode) { _, newValue in
                let digits = newValue.filter { $0.isNumber }
                let maxVerificationCodeLength = 6
                verificationCode = String(digits.prefix(maxVerificationCodeLength))
            }
            CountdownText(endDate: $expirationTime, isExpired: $isExpired)
        }
        .padding(.horizontal, fs(14))
        .padding(.vertical, fs(18))
        .background(.white)
        .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: sharedCornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: sharedCornerRadius))
        .opacity(isSentVerificationCode.value ? 1 : 0)
        .focused($focusField, equals: .verificationCode)
    }

    var invalidVerificationCodeText: some View {
        Text("인증번호를 다시 확인해주세요")
            .font(.pretendardRegular(size: fs(13)))
            .foregroundStyle(.red)
            .padding(.horizontal, fs(2))
            .opacity(isVarifiedCode.value == false ? 1 : 0)
    }

    // MARK: Private Method

    private func formattedPhoneNumberInput(_ phoneNumber: String) -> String {
        let length = phoneNumber.count
        if length <= 3 {
            return phoneNumber 
        } else if length <= 7 {
            let prefix = phoneNumber.prefix(3)
            let suffix = phoneNumber.dropFirst(3)
            return "\(prefix)-\(suffix)"
        } else {
            let part1 = phoneNumber.prefix(3)
            let part2 = phoneNumber.dropFirst(3).prefix(4)
            let part3 = phoneNumber.dropFirst(7)
            return "\(part1)-\(part2)-\(part3)"
        }
    }

    private func didTapRequestVerificationCodeButton() {
        if !isJustSentVerificationCode {
            focusField = .verificationCode
            interactor.requestVerificationCode(
                with: rawPhoneNumber,
                isSentVerificationCode: $isSentVerificationCode,
                expirationTime: $expirationTime,
                isExpired: $isExpired,
                e: $error
            )
        } else {
            interactor.resendVerificationCode(
                with: rawPhoneNumber,
                verificationCode: $verificationCode,
                expirationTime: $expirationTime,
                isExpired: $isExpired,
                e: $error
            )
        }
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
    PhoneVerificationView()
}
