// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct TurnaroundSelectView: View {
  @Binding var selectedTurnaround: TurnaroundFilter

  private var selectedItemBinding: Binding<TurnaroundFilterItem> {
    Binding<TurnaroundFilterItem>(
      get: { TurnaroundFilterItem(turnaroundFilter: selectedTurnaround) },
      set: { selectedTurnaround = $0.turnaroundFilter }
    )
  }

  private let turnaroundItemList: [TurnaroundFilterItem] = TurnaroundFilter.allCases
    .map { TurnaroundFilterItem(turnaroundFilter: $0) }

  var body: some View {
    RadioButtonList(selectedItem: selectedItemBinding, itemList: turnaroundItemList)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct TurnaroundFilterItem: RadioButtonItem {
  let turnaroundFilter: TurnaroundFilter

  var id: TurnaroundFilter {
    turnaroundFilter
  }

  var title: String {
    turnaroundFilter.name
  }
}

private extension TurnaroundFilter {
  var name: String {
    switch self {
    case .all:
      "전체"
    case .lessThanOrEqual1Month:
      "한달 이하"
    case .lessThanOrEqual3Weeks:
      "3주 이하"
    case .lessThanOrEqual2Weeks:
      "2주 이하"
    case .lessThanOrEqual1Week:
      "1주 이하"
    case .lessThanOrEqual5Days:
      "5일 이하"
    case .lessThanOrEqual3Days:
      "3일 이하"
    case .sameDay:
      "당일 제작"
    }
  }
}

#Preview {
  TurnaroundSelectView(selectedTurnaround: .constant(.all))
}
