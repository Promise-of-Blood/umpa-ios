// Created for Umpa in 2025

import SwiftUI

struct RadioButtonList<Item: RadioButtonItem>: View {
    @Binding var selectedItem: Item

    let itemList: [Item]

    private let itemSpacing: CGFloat = 20
    private let foregroundColor: Color = UmpaColor.mainBlue

    var body: some View {
        VStack(alignment: .leading, spacing: itemSpacing) {
            ForEach(itemList, id: \.self) { item in
                Button(action: {
                    selectedItem = item
                }) {
                    HStack(spacing: 12) {
                        RadioButton(isSelected: selectedItem == item)
                        Text(item.title)
                            .font(.pretendardMedium(size: fs(16)))
                            .foregroundStyle(selectedItem == item ? .black : UmpaColor.mediumGray)
                    }
                }
            }
        }
    }
}

private struct RadioButton: View {
    let isSelected: Bool

    private let foregroundColor: Color = UmpaColor.mainBlue
    private let size: CGFloat = 24
    private let innerCircleRatio: CGFloat = 0.55

    var body: some View {
        ZStack {
            backgroundCircle
            foregroundCircle
            innerCircle
        }
    }

    var backgroundCircle: some View {
        Circle()
            .strokeBorder(UmpaColor.lightGray)
            .frame(width: size, height: size)
    }

    var foregroundCircle: some View {
        Circle()
            .frame(width: size - 1, height: size - 1)
            .foregroundStyle(isSelected ? foregroundColor : .white)
    }

    var innerCircle: some View {
        Circle()
            .frame(width: size * innerCircleRatio, height: size * innerCircleRatio)
            .foregroundStyle(.white)
    }
}

protocol RadioButtonItem: Hashable {
    var title: String { get }
}

extension String: RadioButtonItem {
    var title: String { self }
}

#Preview {
    @Previewable @State var selectedItem = "1"

    RadioButtonList(
        selectedItem: $selectedItem,
        itemList: [
            "1",
            "2",
            "3",
        ]
    )
}
