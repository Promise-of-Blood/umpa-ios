// Created for Umpa in 2025

import BaseFeature
import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct RegionSelectView: View {
  @Binding var selectedRegions: [Region]

  var body: some View {
    content
  }

  var content: some View {
    VStack(spacing: fs(14)) {
      selectedRegionChipList
      UmpaRegionSelector(selectedRegions: $selectedRegions)
        .innerStroke(UmpaColor.lightGray, edges: .vertical)
        .clipped()
    }
  }

  var selectedRegionChipList: some View {
    Group {
      if selectedRegions.isEmpty {
        Text("지역을 선택해 주세요")
          .font(.pretendardRegular(size: fs(15)))
          .foregroundStyle(UmpaColor.lightGray)
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: fs(8)) {
            ForEach(selectedRegions, id: \.name) { region in
              RegionChip(region: region, destructiveAction: {
                withAnimation {
                  selectedRegions.removeAll { $0 == region }
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
    .animation(.default, value: selectedRegions)
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
  @Previewable @State var selectedRegions: [Region] = []

  RegionSelectView(selectedRegions: $selectedRegions)
}
