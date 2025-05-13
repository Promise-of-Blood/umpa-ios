// Created for Umpa in 2025

import SwiftUI

struct MRCreationFeeSelectView: View {
    @Binding var selectedMRCreationFee: MRCreationFeeFilter

    private var selectedItemBinding: Binding<MRCreationFeeFilterItem> {
        Binding<MRCreationFeeFilterItem>(
            get: { MRCreationFeeFilterItem(feeFilter: selectedMRCreationFee) },
            set: { selectedMRCreationFee = $0.feeFilter }
        )
    }

    private let mrCreationFeeItemList: [MRCreationFeeFilterItem] = MRCreationFeeFilter.allCases
        .map { MRCreationFeeFilterItem(feeFilter: $0) }

    var body: some View {
        RadioButtonList(selectedItem: selectedItemBinding, itemList: mrCreationFeeItemList)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct MRCreationFeeFilterItem: RadioButtonItem {
    let feeFilter: MRCreationFeeFilter

    var id: MRCreationFeeFilter {
        feeFilter
    }

    var title: String {
        feeFilter.name
    }
}

private extension MRCreationFeeFilter {
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
    MRCreationFeeSelectView(selectedMRCreationFee: .constant(.all))
}
