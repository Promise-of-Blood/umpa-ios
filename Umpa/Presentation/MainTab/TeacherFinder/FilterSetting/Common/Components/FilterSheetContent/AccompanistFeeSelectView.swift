// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct AccompanistFeeSelectView: View {
  @Binding var selectedAccompanistFee: AccompanistFeeFilter

  private var selectedItemBinding: Binding<AccompanistFeeFilterItem> {
    Binding<AccompanistFeeFilterItem>(
      get: { AccompanistFeeFilterItem(accompanistFee: selectedAccompanistFee) },
      set: { selectedAccompanistFee = $0.accompanistFee }
    )
  }

  private let accompanistFeeItemList: [AccompanistFeeFilterItem] = AccompanistFeeFilter.allCases
    .map { AccompanistFeeFilterItem(accompanistFee: $0) }

  var body: some View {
    RadioButtonList(selectedItem: selectedItemBinding, itemList: accompanistFeeItemList)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct AccompanistFeeFilterItem: RadioButtonItem {
  let accompanistFee: AccompanistFeeFilter

  var id: AccompanistFeeFilter {
    accompanistFee
  }

  var title: String {
    accompanistFee.name
  }
}

private extension AccompanistFeeFilter {
  var name: String {
    switch self {
    case .all:
      "전체"
    case .lessThanOrEqual500000krwPerSchool:
      "학교당 50만원 이하"
    case .lessThanOrEqual450000krwPerSchool:
      "학교당 45만원 이하"
    case .lessThanOrEqual400000krwPerSchool:
      "학교당 40만원 이하"
    case .lessThanOrEqual350000krwPerSchool:
      "학교당 35만원 이하"
    case .lessThanOrEqual300000krwPerSchool:
      "학교당 30만원 이하"
    case .lessThanOrEqual250000krwPerSchool:
      "학교당 25만원 이하"
    case .lessThanOrEqual200000krwPerSchool:
      "학교당 20만원 이하"
    case .lessThanOrEqual150000krwPerSchool:
      "학교당 15만원 이하"
    case .lessThanOrEqual100000krwPerSchool:
      "학교당 10만원 이하"
    }
  }
}

#Preview {
  @Previewable @State var selectedAccompanistFee: AccompanistFeeFilter = .all

  AccompanistFeeSelectView(selectedAccompanistFee: $selectedAccompanistFee)
}
