// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct ScoreCreationFeeSelectView: View {
  @Binding var selectedScoreCreationFee: ScoreCreationFeeFilter

  private var selectedItemBinding: Binding<ScoreCreationFeeFilterItem> {
    Binding<ScoreCreationFeeFilterItem>(
      get: { ScoreCreationFeeFilterItem(feeFilter: selectedScoreCreationFee) },
      set: { selectedScoreCreationFee = $0.feeFilter }
    )
  }

  private let scoreCreationFeeItemList: [ScoreCreationFeeFilterItem] = ScoreCreationFeeFilter.allCases
    .map { ScoreCreationFeeFilterItem(feeFilter: $0) }

  var body: some View {
    RadioButtonList(selectedItem: selectedItemBinding, itemList: scoreCreationFeeItemList)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct ScoreCreationFeeFilterItem: RadioButtonItem {
  let feeFilter: ScoreCreationFeeFilter

  var id: ScoreCreationFeeFilter {
    feeFilter
  }

  var title: String {
    feeFilter.name
  }
}

private extension ScoreCreationFeeFilter {
  var name: String {
    switch self {
    case .all:
      "전체"
    case .lessThanOrEqual500000krwPerMusic:
      "곡 당 50만원 이하"
    case .lessThanOrEqual400000krwPerMusic:
      "곡 당 40만원 이하"
    case .lessThanOrEqual300000krwPerMusic:
      "곡 당 30만원 이하"
    case .lessThanOrEqual200000krwPerMusic:
      "곡 당 20만원 이하"
    case .lessThanOrEqual100000krwPerMusic:
      "곡 당 10만원 이하"
    case .lessThanOrEqual50000krwPerMusic:
      "곡 당 5만원 이하"
    case .lessThanOrEqual30000krwPerMusic:
      "곡 당 3만원 이하"
    }
  }
}

#Preview {
  ScoreCreationFeeSelectView(selectedScoreCreationFee: .constant(.all))
}
