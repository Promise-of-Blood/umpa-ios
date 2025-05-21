// Created for Umpa in 2025

import BaseFeature
import Domain
import SwiftUI
import UmpaUIKit

struct LessonRegionSettingSheet: SettingSheet {
  @Binding var isPresenting: Bool
  @Binding var truthRegions: [Region]

  @State private var editableRegionList: Editable<[Region]> = .confirmed([])

  var body: some View {
    InstinctHeightSheet(
      isPresenting: $isPresenting,
      dismissAction: {
        editableRegionList.cancel()
      }
    ) {
      content
    }
    .onChange(of: truthRegions, initial: true) { _, newValue in
      editableRegionList.confirm(newValue)
    }
  }

  @ViewBuilder
  var content: some View {
    VStack(spacing: fs(10)) {
      VStack(spacing: fs(12)) {
        title("레슨 지역")
        VStack(spacing: fs(8)) {
          selectedRegionChipList
          UmpaRegionSelector(
            selectedRegions: Binding(
              get: { editableRegionList.current },
              set: { editableRegionList.setEditing($0) }
            )
          )
          .innerStroke(UmpaColor.lightGray, edges: .vertical)
        }
      }
      acceptButton {
        truthRegions = editableRegionList.current
        isPresenting = false
      }
    }
  }

  @ViewBuilder
  var selectedRegionChipList: some View {
    Group {
      if editableRegionList.current.isEmpty {
        Text("지역을 선택해 주세요")
          .font(.pretendardRegular(size: fs(15)))
          .foregroundStyle(UmpaColor.lightGray)
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: fs(8)) {
            ForEach(editableRegionList.current, id: \.name) { region in
              RegionChip(region: region, destructiveAction: {
                withAnimation {
                  var newValue = editableRegionList.current
                  newValue.removeAll { $0 == region }
                  editableRegionList.setEditing(newValue)
                }
              })
            }
          }
          .padding(.horizontal, fs(16))
        }
        .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
      }
    }
    .frame(height: fs(30))
    .animation(.default, value: editableRegionList.current)
  }
}

private struct RegionChip: View {
  private let height: CGFloat = fs(28)
  private let foregroundColor: Color = UmpaColor.mainBlue

  let region: Region
  let destructiveAction: () -> Void

  var body: some View {
    HStack(spacing: fs(8)) {
      Text(region.name)
        .font(.pretendardMedium(size: fs(12)))
      Button(action: destructiveAction) {
        Image(systemSymbol: .xmark)
          .font(.system(size: 12, weight: .medium))
          .foregroundStyle(.red)
      }
    }
    .frame(height: height)
    .padding(.horizontal, fs(10))
    .innerRoundedStroke(foregroundColor, cornerRadius: height / 2)
    .foregroundStyle(foregroundColor)
  }
}

private extension Region {
  var name: String {
    "\(regionalLocalGovernment) · \(basicLocalGovernment.name)"
  }
}

#Preview {
  @Previewable @State var isPresenting = false
  @Previewable @State var regions: [Region] = []
  @Previewable @State var appState = AppState.overrideForPreview()

  ZStack {
    VStack(spacing: 30) {
      Button("Make to empty") {
        regions = []
      }
      Button("Present") {
        isPresenting = true
      }
    }
    Spacer()
    LessonRegionSettingSheet(
      isPresenting: $isPresenting,
      truthRegions: $regions,
    )
  }
  .environment(appState)
}
