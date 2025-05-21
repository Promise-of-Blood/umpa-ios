// Created for Umpa in 2025

import SwiftUI

public enum ToggleButtons {
  public struct Appearance {
    let enabledForegroundColor: Color
    let disabledForegroundColor: Color
    let enabledBackgroundColor: Color
    let disabledBackgroundColor: Color
    let enabledBorderColor: Color
    let disabledBorderColor: Color
    let cornerRadius: CGFloat

    public static func fromDefault(
      enabledForegroundColor: Color = UmpaColor.mainBlue,
      disabledForegroundColor: Color = UmpaColor.mediumGray,
      enabledBackgroundColor: Color = UmpaColor.lightBlue,
      disabledBackgroundColor: Color = .white,
      enabledBorderColor: Color = UmpaColor.mainBlue,
      disabledBorderColor: Color = UmpaColor.baseColor,
      cornerRadius: CGFloat = fs(15)
    ) -> Appearance {
      Appearance(
        enabledForegroundColor: enabledForegroundColor,
        disabledForegroundColor: disabledForegroundColor,
        enabledBackgroundColor: enabledBackgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        enabledBorderColor: enabledBorderColor,
        disabledBorderColor: disabledBorderColor,
        cornerRadius: cornerRadius
      )
    }
  }

  public protocol SelectableItem: Hashable {
    var label: String { get }
//    var image: ImageResource? { get }
  }

  public struct LabelItem: SelectableItem {
    public let label: String

    public init(_ label: String) {
      self.label = label
    }
  }
}

extension ToggleButtons {
  public struct V1<Item: SelectableItem>: View {
    @Binding var selection: [(item: Item, isSelected: Bool)]

    let appearance: Appearance
    let multiSelectable: Bool

    public init(
      selection: Binding<[(item: Item, isSelected: Bool)]>,
      appearance: Appearance = .fromDefault(),
      multiSelectable: Bool = true,
    ) {
      _selection = selection
      self.appearance = appearance
      self.multiSelectable = multiSelectable
    }

    /// 단일 항목 선택 전용으로 생성합니다.
    public init(
      selectedItem: Binding<Item?>,
      itemList: [Item],
      appearance: Appearance = .fromDefault(),
    ) {
      _selection = Binding(
        get: {
          itemList.map { item in
            (item, selectedItem.wrappedValue == item)
          }
        },
        set: { newValue in
          selectedItem.wrappedValue =
            newValue.first(where: \.isSelected)?.item
        }
      )

      self.appearance = appearance
      multiSelectable = false
    }

    public init(
      selectedItem: Binding<String?>,
      itemList: [String],
      appearance: Appearance = .fromDefault(),
    ) where Item == LabelItem {
      _selection = Binding(
        get: {
          itemList.map { label in
            (LabelItem(label), selectedItem.wrappedValue == label)
          }
        },
        set: { newValue in
          selectedItem.wrappedValue = newValue.first(where: \.isSelected)?.item.label
        }
      )

      self.appearance = appearance
      multiSelectable = false
    }

    public var body: some View {
      HStack(spacing: fs(8)) {
        ForEach(selection, id: \.item) { item, isSelected in
          Button(action: {
            didTapItem(item)
          }) {
            VStack(spacing: fs(10)) {
              //              if let imageResource = item.image {
              //                Image(imageResource)
              //                  .resizable()
              //                  .aspectRatio(contentMode: .fit)
              //
              //              }
              Text(item.label)
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(
                  isSelected
                    ? appearance.enabledForegroundColor
                    : appearance.disabledForegroundColor
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, fs(18))
                .padding(.vertical, fs(14))
                .background(
                  isSelected ? appearance.enabledBackgroundColor : appearance.disabledBackgroundColor,
                  in: RoundedRectangle(cornerRadius: appearance.cornerRadius)
                )
                .innerRoundedStroke(
                  isSelected ? appearance.enabledBorderColor : appearance.disabledBorderColor,
                  cornerRadius: appearance.cornerRadius
                )
            }
          }
        }
      }
      .fixedSize(horizontal: false, vertical: true)
    }

    private func didTapItem(_ item: Item) {
      if multiSelectable {
        if let index = selection.firstIndex(where: { $0.item == item }) {
          selection[index].isSelected.toggle()
        }
      } else {
        selection = selection.map { (item: $0.item, isSelected: $0.item == item) }
      }
    }
  }
}

#Preview("복수 선택") {
  @Previewable @State var selection: [(item: TestingToggleButtonsItem, isSelected: Bool)] = [
    (item: TestingToggleButtonsItem(label: "짧은 항목"), isSelected: false),
    (item: TestingToggleButtonsItem(label: "기이이이이이이인 항목"), isSelected: false),
  ]

  ToggleButtons.V1(selection: $selection)
    .padding()
    .onChange(of: selection.map(\.isSelected)) {
      print("selection: \(selection)")
    }
}

#Preview("단수 선택") {
  @Previewable @State var selectedItem: TestingToggleButtonsItem? = nil

  ToggleButtons.V1(
    selectedItem: $selectedItem,
    itemList: [
      TestingToggleButtonsItem(label: "짧은 항목"),
      TestingToggleButtonsItem(label: "기이이이이이이인 항목"),
    ],
  )
  .padding()
  .onChange(of: selectedItem) {
    print("selectedItem: \(String(describing: selectedItem))")
  }
}
