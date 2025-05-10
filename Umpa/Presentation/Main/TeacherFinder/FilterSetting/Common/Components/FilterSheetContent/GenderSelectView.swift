// Created for Umpa in 2025

import Domain
import SwiftUI

struct GenderSelectView: View {
    @Binding var selectedGender: GenderFilter

    private var genderItemBinding: Binding<GenderItem> {
        Binding<GenderItem>(
            get: { GenderItem(gender: selectedGender) },
            set: { selectedGender = $0.gender }
        )
    }

    private let genderItemList: [GenderItem] = [
        GenderItem(gender: .all),
        GenderItem(gender: .female),
        GenderItem(gender: .male),
    ]

    var body: some View {
        RadioButtonList(selectedItem: genderItemBinding, itemList: genderItemList)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct GenderItem: RadioButtonItem {
    let gender: GenderFilter

    var id: GenderFilter {
        gender
    }

    var title: String {
        gender.name
    }
}

#Preview {
    @Previewable @State var selectedGenderFilter: GenderFilter = .all

    GenderSelectView(selectedGender: $selectedGenderFilter)
}
