// Created for Umpa in 2025

import Domain
import Factory
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct AcceptTermsView: View {
  enum NavigationDestination {
    case userTypeSelection
  }

  @Injected(\.acceptTermsInteractor) private var interactor

  @State private var hasAcceptedPersonalInformationTerms: Bool = false
  @State private var hasAcceptedServiceUsageTerms: Bool = false
  @State private var hasAcceptedElectronicFinancialTransactionsTerms: Bool = false

  private var hasAcceptedAllTerms: Bool {
    hasAcceptedPersonalInformationTerms &&
      hasAcceptedServiceUsageTerms &&
      hasAcceptedElectronicFinancialTransactionsTerms
  }

  private let largeCheckBoxSize: CGFloat = fs(32)
  private let smallCheckBoxSize: CGFloat = fs(24)

  private let termsItemSpacing: CGFloat = fs(15)

  // MARK: View

  var body: some View {
    content
      .navigationDestination(for: NavigationDestination.self) {
        switch $0 {
        case .userTypeSelection:
          UserTypeSelectionView()
        }
      }
  }

  var content: some View {
    VStack {
      VStack(alignment: .leading, spacing: fs(70)) {
        Text("약관을 확인해주세요")
          .font(SignUpConstant.titleFont)
          .foregroundStyle(SignUpConstant.titleColor)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, SignUpConstant.titleTopPaddingWithoutProgressView)
        acceptSection
      }
      .padding(.horizontal, SignUpConstant.contentHorizontalPadding)

      Spacer()

      SignUpBottomButton(action: interactor.moveToNext) {
        Text("다음")
      }
      .disabled(!hasAcceptedAllTerms)
    }
    .background(.white)
  }

  var acceptSection: some View {
    VStack(alignment: .leading, spacing: fs(44)) {
      HStack(spacing: fs(16)) {
        ToggleCheckView(
          isChecked: .constant(hasAcceptedAllTerms),
          size: largeCheckBoxSize,
          action: performAllTermsAccepting
        )
        Text("전체 동의")
          .font(.pretendardBold(size: fs(22)))
          .foregroundStyle(.black)
      }

      VStack(alignment: .leading, spacing: fs(34)) {
        HStack {
          HStack(spacing: termsItemSpacing) {
            ToggleCheckView(
              isChecked: $hasAcceptedPersonalInformationTerms,
              size: smallCheckBoxSize
            )
            Text(AcceptTermsItem.personalInformation.title)
              .font(.pretendardRegular(size: fs(16)))
              .foregroundStyle(.black)
          }
          Spacer()
          Button(action: {
            // TODO: Show content of the terms
          }) {
            Image(systemSymbol: .chevronDown)
              .foregroundStyle(.black)
          }
        }
        HStack {
          HStack(spacing: termsItemSpacing) {
            ToggleCheckView(
              isChecked: $hasAcceptedServiceUsageTerms,
              size: smallCheckBoxSize
            )
            Text(AcceptTermsItem.serviceUsage.title)
              .font(.pretendardRegular(size: fs(16)))
              .foregroundStyle(.black)
          }
          Spacer()
          Button(action: {
            // TODO: Show content of the terms
          }) {
            Image(systemSymbol: .chevronDown)
              .foregroundStyle(.black)
          }
        }
        HStack {
          HStack(spacing: termsItemSpacing) {
            ToggleCheckView(
              isChecked: $hasAcceptedElectronicFinancialTransactionsTerms,
              size: smallCheckBoxSize
            )
            Text(AcceptTermsItem.electronicFinancialTransactions.title)
              .font(.pretendardRegular(size: fs(16)))
              .foregroundStyle(.black)
          }
          Spacer()
          Button(action: {
            // TODO: Show content of the terms
          }) {
            Image(systemSymbol: .chevronDown)
              .foregroundStyle(.black)
          }
        }
      }
      .padding(.horizontal, fs(8))
    }
  }

  private func performAllTermsAccepting() {
    let valueToChange = !hasAcceptedAllTerms
    hasAcceptedPersonalInformationTerms = valueToChange
    hasAcceptedServiceUsageTerms = valueToChange
    hasAcceptedElectronicFinancialTransactionsTerms = valueToChange
  }
}

private struct ToggleCheckView: View {
  @Binding var isChecked: Bool

  let action: (() -> Void)?

  private let circleSize: CGFloat
  private var checkmarkSize: CGFloat {
    circleSize * 0.6
  }

  init(isChecked: Binding<Bool>, size: CGFloat, action: (() -> Void)? = nil) {
    _isChecked = isChecked
    self.action = action
    circleSize = size
  }

  var body: some View {
    Button(action: didTap) {
      ZStack {
        Circle()
          .frame(width: circleSize, height: circleSize)
          .foregroundStyle(isChecked ? UmpaColor.mainBlue : UmpaColor.mediumGray)
        Image(systemSymbol: .checkmark)
          .font(.system(size: checkmarkSize, weight: .medium))
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(.borderless)
  }

  private func didTap() {
    isChecked.toggle()
    action?()
  }
}

private extension AcceptTermsItem {
  var title: String {
    switch self {
    case .personalInformation:
      "(필수) 개인정보 수집 이용"
    case .serviceUsage:
      "(필수) 서비스 이용사항"
    case .electronicFinancialTransactions:
      "(필수) 전자 금융거래 이용약관"
    }
  }
}

#Preview {
  AcceptTermsView()
}
