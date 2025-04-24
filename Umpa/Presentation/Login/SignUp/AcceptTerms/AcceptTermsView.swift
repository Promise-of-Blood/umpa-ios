// Created for Umpa in 2025

import Domain
import Factory
import SFSafeSymbols
import SwiftUI

struct AcceptTermsView: View {
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
            .navigationDestination(for: SignUpRoute.self) { route in
                if case .userTypeSelection = route {
                    UserTypeSelectionView()
                }
            }
    }

    var content: some View {
        VStack {
            VStack(alignment: .leading, spacing: fs(70)) {
                Text("약관을 확인해주세요")
                    .font(SignUpSharedUIConstant.titleFont)
                    .foregroundStyle(SignUpSharedUIConstant.titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, SignUpSharedUIConstant.titleTopPadding)
                acceptSection
            }
            .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)

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
        self._isChecked = isChecked
        self.action = action
        self.circleSize = size
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
            return "(필수) 개인정보 수집 이용"
        case .serviceUsage:
            return "(필수) 서비스 이용사항"
        case .electronicFinancialTransactions:
            return "(필수) 전자 금융거래 이용약관"
        }
    }
}

#Preview {
    AcceptTermsView()
}
