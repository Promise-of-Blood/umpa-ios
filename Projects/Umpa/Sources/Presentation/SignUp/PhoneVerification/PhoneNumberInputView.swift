// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct PhoneVerificationView: View {
  enum FocusField: Hashable {
    case phoneNumber
  }

  enum NavigationDestination {
    case verificationCodeInput
  }

  /// 하이픈(-)을 제외한 실제 전화번호 문자열 (01012345678)
  @State private var rawPhoneNumber: String = ""

  /// 텍스트필드에 표시될 전화번호 문자열 (1234-5678)
  @State private var formattedPhoneNumber: String = ""

  @State private var error: PhoneVerificationError?

  @FocusState private var focusField: FocusField?

#if DEBUG
  @Injected(\.mockPhoneVerificationInteractor)
#else
  @Injected(\.phoneVerificationInteractor)
#endif
  private var interactor: PhoneVerificationInteractor

  private let cornerRadius: CGFloat = fs(10)

  private let phoneNumberPrefix: String = "010"

  // MARK: View

  var body: some View {
    content
      .errorAlert($error)
      .onAppear {
        focusField = .phoneNumber
      }
      .navigationDestination(for: NavigationDestination.self) {
        switch $0 {
        case .verificationCodeInput:
          VerificationCodeInputView(rawPhoneNumber: rawPhoneNumber)
        }
      }
  }

  @ViewBuilder
  var content: some View {
    VStack {
      VStack(alignment: .leading, spacing: fs(60)) {
        header
        phoneNumberInputBox
      }
      .frame(maxWidth: .infinity)
      .padding(.top, SignUpConstant.titleTopPaddingWithoutProgressView)
      .padding(.horizontal, SignUpConstant.contentHorizontalPadding)

      Spacer()

      SignUpBottomButton {
        interactor.sendVerificationCodeAndMoveToNext(with: rawPhoneNumber, e: $error)
      } label: {
        Text("인증번호 발송")
      }
      .disabled(!PhoneNumberValidator(rawPhoneNumber: rawPhoneNumber).validate())
    }
    .background(.white)
  }

  var header: some View {
    VStack(alignment: .leading, spacing: fs(24)) {
      TitleText("전화번호를 입력해주세요")
        .padding(.top, SignUpConstant.titleTopPaddingWithoutProgressView)
      Text("음파 서비스를 이용하기 위해서 휴대전화번호 인증이 필요합니다. 번호는 외부에 노출되지 않습니다.")
        .font(.pretendardRegular(size: fs(13)))
        .foregroundStyle(UmpaColor.mediumGray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
    .frame(maxWidth: .infinity)
  }

  var phoneNumberInputBox: some View {
    HStack(spacing: fs(10)) {
      Text(phoneNumberPrefix)
        .foregroundStyle(UmpaColor.darkGray)
      TextField(
        text: $formattedPhoneNumber,
        prompt: Text("휴대폰 번호 입력"),
        label: { Text("휴대폰 번호 입력") }
      )
      .foregroundStyle(.black)
      .keyboardType(.numberPad)
      .autocorrectionDisabled()
      .onChange(of: formattedPhoneNumber) { _, newValue in
        let digits = newValue.filter(\.isNumber)
        // 최대 8자리까지만 허용
        let phoneNumber = String(digits.prefix(8))
        rawPhoneNumber = phoneNumberPrefix + phoneNumber
        formattedPhoneNumber = PhoneNumberFormatter(phoneNumber).semiFormatted()
      }
      .focused($focusField, equals: .phoneNumber)
    }
    .padding(.horizontal, fs(16))
    .padding(.vertical, fs(18))
    .background(.white)
    .innerRoundedStroke(UmpaColor.mediumGray, cornerRadius: cornerRadius)
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
}

#Preview {
  NavigationStack {
    PhoneVerificationView()
  }
}
