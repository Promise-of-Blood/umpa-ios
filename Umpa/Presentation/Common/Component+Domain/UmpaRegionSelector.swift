// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct UmpaRegionSelector: View {
  @Injected(\.appState) private var appState

  @Binding var selectedRegions: [Region]

  private var selectedRegionBinding: Binding<[(RegionCategoryItem, RegionItem)]> {
    Binding(
      get: {
        selectedRegions.map { region in
          let categoryItem = region.regionalLocalGovernment.toRegionCategoryItem()
          let regionItem = region.basicLocalGovernment.toRegionItem()
          return (categoryItem, regionItem)
        }
      },
      set: {
        selectedRegions = $0.compactMap { region in
          guard let basicLocalGovernmentList = appState.appData.regionList[region.0.label],
                let basicLocalGovernment = basicLocalGovernmentList.first(where: { $0.id == region.1.id })
          else { return nil }
          let regionalLocalGovernment = region.0.label
          return Region(
            regionalLocalGovernment: regionalLocalGovernment,
            basicLocalGovernment: basicLocalGovernment
          )
        }
      }
    )
  }

  private let regionCategoryList: [RegionCategoryItem]

  private let canMultiSelect: Bool

  private var regionDictionary: [RegionCategoryItem: [RegionItem]] {
    appState.appData.regionList.reduce(into: [:]) { result, region in
      let categoryItem = region.key.toRegionCategoryItem()
      let RegionItemList = region.value.toRegionItemList()
      result[categoryItem, default: []].append(contentsOf: RegionItemList)
    }
  }

  init(selectedRegions: Binding<[Region]>) {
    canMultiSelect = true
    _selectedRegions = selectedRegions

    let appState = Container.shared.appState()
    let regionalLocalGovernmentListOrder = appState.system.regionalLocalGovernmentListOrder
    let sortedList = appState.appData.regionList.keys.sorted {
      regionalLocalGovernmentListOrder[$0] ?? Int.max < regionalLocalGovernmentListOrder[$1] ?? Int.max
    }
    regionCategoryList = sortedList.map { $0.toRegionCategoryItem() }
  }

  init(selectedRegion: Binding<Region?>) {
    canMultiSelect = false

    let selectedRegions = Binding<[Region]>(
      get: { selectedRegion.wrappedValue.map { [$0] } ?? [] },
      set: { selectedRegion.wrappedValue = $0.first }
    )
    _selectedRegions = selectedRegions

    let appState = Container.shared.appState()
    let regionalLocalGovernmentListOrder = appState.system.regionalLocalGovernmentListOrder
    let sortedList = appState.appData.regionList.keys.sorted {
      regionalLocalGovernmentListOrder[$0] ?? Int.max < regionalLocalGovernmentListOrder[$1] ?? Int.max
    }
    regionCategoryList = sortedList.map { $0.toRegionCategoryItem() }
  }

  var body: some View {
    RegionSelector(
      selectedRegions: selectedRegionBinding,
      regionalLocalGovernmentList: regionCategoryList,
      regionDictionary: regionDictionary,
      canMultiSelect: canMultiSelect,
    )
  }
}

private struct RegionCategoryItem: UmpaUIKit.RegionalLocalGovernment {
  let id: String
  let label: String
}

private struct RegionItem: UmpaUIKit.BasicLocalGovernment {
  let id: Int
  let label: String
}

private extension Domain.RegionalLocalGovernment {
  func toRegionCategoryItem() -> RegionCategoryItem {
    RegionCategoryItem(id: self + "_category", label: self)
  }
}

private extension Domain.BasicLocalGovernment {
  func toRegionItem() -> RegionItem {
    RegionItem(id: id, label: name)
  }
}

private extension [Domain.BasicLocalGovernment] {
  func toRegionItemList() -> [RegionItem] {
    map { $0.toRegionItem() }
  }
}
