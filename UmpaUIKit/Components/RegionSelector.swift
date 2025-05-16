// Created for Umpa in 2025

import SwiftUI

public protocol RegionalLocalGovernment: Identifiable, Hashable {
  var id: ID { get }
  var label: String { get }
}

public protocol BasicLocalGovernment: Identifiable, Hashable {
  var id: ID { get }
  var label: String { get }
}

public struct RegionSelector<C: RegionalLocalGovernment, R: BasicLocalGovernment>: View {
  @State private var selectedRegionalLocalGovernment: Optional<C>

  /// 지역 목록. [<특별시, 광역시, 도>:  <시, 군, 구>]
  private let regionDictionary: [C: [R]]

  @Binding var selectedRegions: [(C, R)]

  private let canMultiSelect: Bool

  /// 특별시, 광역시, 도
  private let regionalLocalGovernmentList: [C]

  /// 시, 군, 구
  private var basicLocalGovernmentList: [R] {
    if let selectedRegionalLocalGovernment {
      regionDictionary[selectedRegionalLocalGovernment] ?? []
    } else {
      []
    }
  }

  private let selectionBackgroundColor: Color = .init(hex: "D6E1FF")
  private let selectionForegroundColor: Color = .init(hex: "003BDE")
  private let badgeForegroundColor: Color = UmpaColor.mainBlue

  private let rowHeight: CGFloat = fs(48)
  private let rowSpacing: CGFloat = 1

  public init(
    selectedRegions: Binding<[(C, R)]>,
    regionalLocalGovernmentList: [C],
    regionDictionary: [C: [R]],
    canMultiSelect: Bool = true,
  ) {
    _selectedRegions = selectedRegions
    self.regionDictionary = regionDictionary
    self.regionalLocalGovernmentList = regionalLocalGovernmentList
    self.canMultiSelect = canMultiSelect

    if let firstSelected = selectedRegions.wrappedValue.first {
      selectedRegionalLocalGovernment = firstSelected.0
    } else {
      selectedRegionalLocalGovernment = regionalLocalGovernmentList.first
    }
  }

  public init(
    selectedRegion: Binding<(C, R)?>,
    regionalLocalGovernmentList: [C],
    regionDictionary: [C: [R]],
  ) {
    canMultiSelect = false
    self.regionalLocalGovernmentList = regionalLocalGovernmentList
    self.regionDictionary = regionDictionary

    let selectedRegionsBinding: Binding<[(C, R)]> = Binding(
      get: {
        selectedRegion.wrappedValue.map { [$0] } ?? []
      },
      set: { regions in
        selectedRegion.wrappedValue = regions.first
      }
    )
    _selectedRegions = selectedRegionsBinding

    if let selectedRegion = selectedRegion.wrappedValue {
      selectedRegionalLocalGovernment = selectedRegion.0
    } else {
      selectedRegionalLocalGovernment = regionalLocalGovernmentList.first
    }
  }

  // MARK: View

  public var body: some View {
    content
  }

  var content: some View {
    HStack(spacing: 1) {
      regionalLocalGovernmentScrollView
      basicLocalGovernmentScrollView
    }
  }

  var regionalLocalGovernmentScrollView: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(spacing: rowSpacing) {
          IndexingForEach(regionalLocalGovernmentList) { _, region in
            Button {
              selectedRegionalLocalGovernment = region
            } label: {
              Text(region.label)
                .font(.pretendardRegular(size: fs(14)))
                .foregroundStyle(selectedRegionalLocalGovernment == region
                  ? selectionForegroundColor
                  : UmpaColor.darkGray)
                  .frame(width: fs(100), height: rowHeight)
                  .background(selectedRegionalLocalGovernment == region
                    ? selectionBackgroundColor
                    : Color(hex: "F8F9FA"))
            }
            .id(region.id)
          }
        }
      }
      .scrollIndicators(.never)
      .onAppear {
        proxy.scrollTo(selectedRegionalLocalGovernment, anchor: .center)
      }
    }
  }

  var basicLocalGovernmentScrollView: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(spacing: rowSpacing) {
          IndexingForEach(basicLocalGovernmentList) { _, region in
            Button {
              didSelectedLocalGovernment(region)
            } label: {
              Text(region.label)
                .font(.pretendardRegular(size: fs(14)))
                .foregroundStyle(selectedRegions.containsLocalGovernment(region)
                  ? selectionForegroundColor
                  : UmpaColor.darkGray)
                  .frame(maxWidth: .infinity, height: rowHeight)
                  .background(selectedRegions.containsLocalGovernment(region)
                    ? selectionBackgroundColor
                    : .white)
            }
            .id(region.id)
          }
        }
      }
      .onAppear {
        if let selectedBasicLocalGovernment = selectedRegions.first?.1 {
          proxy.scrollTo(selectedBasicLocalGovernment, anchor: .center)
        }
      }
    }
  }

  // MARK: Private Methods

  private func didSelectedLocalGovernment(_ localGovernment: R) {
    guard let selectedRegionalLocalGovernment else { return }
    let selectedRegion = (selectedRegionalLocalGovernment, localGovernment)
    if canMultiSelect {
      if selectedRegions.containsLocalGovernment(localGovernment) {
        selectedRegions.removeAll(where: { $0.1.id == localGovernment.id })
      } else {
        selectedRegions.append(selectedRegion)
      }
    } else {
      selectedRegions = [selectedRegion]
    }
  }
}

private extension Array {
  func containsLocalGovernment<C, R>(_ basicLocalGovernment: R) -> Bool
    where Element == (C, R), R: BasicLocalGovernment
  {
    contains { region in
      region.1.id == basicLocalGovernment.id
    }
  }
}

#Preview {
  @Previewable @State var selectedRegions: [(TestRegionCategory, TestRegion)] = []

  RegionSelector(
    selectedRegions: $selectedRegions,
    regionalLocalGovernmentList: sortedRegionList,
    regionDictionary: regionDictionary,
    canMultiSelect: true
  )
}
