// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct PhoneVerificationView: View {
    @State private var phoneNumber: PhoneNumber = .empty()
    @State private var isSentVerificationCode: Bool = false
    @State private var verificationCode: String = ""
    @State private var isEnteredCode: Bool = false

    @Injected(\.phoneVerificationInteractor)
    private var interactor: PhoneVerificationInteractor

    private let sharedCornerRadius: CGFloat = fs(10)

    var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: fs(94)) {
            header
            verificationSection
        }
        .padding(.top, Constant.titleTopPadding)
        .padding(.horizontal, fs(24))
        Spacer()
        SignUpBottomButton(text: "다음") {
            interactor.verifyCodeToNext(verificationCode)
        }
        .disabled(!isEnteredCode)
    }

    var header: some View {
        VStack(alignment: .leading, spacing: fs(38)) {
            Text("전화번호를 입력해주세요")
                .font(.pretendardSemiBold(size: fs(24)))
                .foregroundStyle(UmpaColor.darkBlue)
            Text("음파 서비스를 이용하기 위해서 휴대전화번호 인증이 필요합니다. 번호는 외부에 노출되지 않습니다.")
                .font(.pretendardRegular(size: fs(13)))
                .foregroundStyle(UmpaColor.mediumGray)
        }
    }

    var verificationSection: some View {
        VStack(alignment: .trailing, spacing: fs(18)) {
            TextField(
                text: $phoneNumber.rawNumber,
                prompt: Text("휴대폰 번호 입력 ('-' 제외)"),
                label: {
                    Text("휴대폰 번호")
                }
            )
            .padding(.horizontal, fs(14))
            .padding(.vertical, fs(18))
            .background(.white)
            .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: sharedCornerRadius)
            .clipShape(RoundedRectangle(cornerRadius: sharedCornerRadius))
            .keyboardType(.phonePad)
            .onChange(of: phoneNumber) { _, newValue in
                phoneNumber.rawNumber = newValue.rawNumber.filter { $0.isNumber }
            }

            Button {
                if !isSentVerificationCode {
                    isSentVerificationCode = true
                    interactor.requestVerification(with: phoneNumber)
                } else {
                    interactor.resendVerificationCode()
                }
            } label: {
                Text(!isSentVerificationCode ? "인증 요청" : "인증번호 재발송")
                    .font(.pretendardMedium(size: fs(16)))
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 50)
                    .background(
                        !isSentVerificationCode ? UmpaColor.mainBlue : Color(hex: "D6E1FF"),
                        in: RoundedRectangle(cornerRadius: sharedCornerRadius)
                    )
            }

            TextField(
                text: $verificationCode,
                prompt: Text("인증번호 입력"),
                label: {
                    Text("인증번호")
                }
            )
            .padding(.horizontal, fs(14))
            .padding(.vertical, fs(18))
            .background(.white)
            .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: sharedCornerRadius)
            .clipShape(RoundedRectangle(cornerRadius: sharedCornerRadius))
            .keyboardType(.phonePad)
            .onChange(of: verificationCode) { _, newValue in
                verificationCode = newValue.filter { $0.isNumber }
            }
            .opacity(isSentVerificationCode ? 1 : 0)
        }
    }
}

#Preview {
    PhoneVerificationView()
}
