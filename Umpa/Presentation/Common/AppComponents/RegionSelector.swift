// Created for Umpa in 2025

import Core
import Domain
import Factory
import SwiftUI

public struct RegionSelector: View {
    @Injected(\.appState) private var appState

    @State private var selectedRegionalLocalGovernment: RegionalLocalGovernment

    private let regionalLocalGovernmentList: [RegionalLocalGovernment]

    private var basicLocalGovernmentList: [BasicLocalGovernment] {
        appState.appData.regionList[selectedRegionalLocalGovernment] ?? []
    }

    private let selectionBackgroundColor: Color = .init(hex: "D6E1FF")
    private let selectionForegroundColor: Color = .init(hex: "003BDE")
    private let badgeForegroundColor: Color = UmpaColor.mainBlue

    private let rowHeight: CGFloat = fs(48)
    private let rowSpacing: CGFloat = 1

    let canMultiSelect: Bool

    @Binding var selectedRegions: [Region]

    init(
        selectedRegions: Binding<[Region]>,
        canMultiSelect: Bool = false,
    ) {
        _selectedRegions = selectedRegions
        self.canMultiSelect = canMultiSelect

        if let firstSelectedRegion = selectedRegions.wrappedValue.first {
            selectedRegionalLocalGovernment = firstSelectedRegion.regionalLocalGovernment
        } else {
            selectedRegionalLocalGovernment = RegionSelector.getSortedRegionalLocalGovernmentList().first ?? ""
        }
        regionalLocalGovernmentList = RegionSelector.getSortedRegionalLocalGovernmentList()
    }

    init(selectedRegion: Binding<Region?>) {
        canMultiSelect = false
        let selectedRegionsBinding: Binding<[Region]> = Binding(
            get: {
                selectedRegion.wrappedValue.map { [$0] } ?? []
            },
            set: { regions in
                selectedRegion.wrappedValue = regions.first
            }
        )
        _selectedRegions = selectedRegionsBinding

        if let selectedRegion = selectedRegion.wrappedValue {
            selectedRegionalLocalGovernment = selectedRegion.regionalLocalGovernment
        } else {
            selectedRegionalLocalGovernment = RegionSelector.getSortedRegionalLocalGovernmentList().first ?? ""
        }
        regionalLocalGovernmentList = RegionSelector.getSortedRegionalLocalGovernmentList()
    }

    // MARK: View

    public var body: some View {
        content
    }

    var content: some View {
        HStack(spacing: 1) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: rowSpacing) {
                        IndexingForEach(regionalLocalGovernmentList) { _, name in
                            Button {
                                selectedRegionalLocalGovernment = name
                            } label: {
                                Text(name)
                                    .font(.pretendardRegular(size: fs(14)))
                                    .foregroundStyle(selectedRegionalLocalGovernment == name ?
                                        selectionForegroundColor : UmpaColor.darkGray)
                                    .frame(width: fs(100), height: rowHeight)
                                    .background(selectedRegionalLocalGovernment == name ?
                                        selectionBackgroundColor : Color(hex: "F8F9FA"))
                            }
                            .id(name)
                        }
                    }
                }
                .scrollIndicators(.never)
                .onAppear {
                    proxy.scrollTo(selectedRegionalLocalGovernment, anchor: .center)
                }
            }

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: rowSpacing) {
                        IndexingForEach(basicLocalGovernmentList) { _, region in
                            Button {
                                didSelectedLocalGovernment(region)
                            } label: {
                                Text(region.name)
                                    .font(.pretendardRegular(size: fs(14)))
                                    .foregroundStyle(selectedRegions.containsLocalGovernment(region) ?
                                        selectionForegroundColor : UmpaColor.darkGray)
                                    .frame(maxWidth: .infinity, height: rowHeight)
                                    .background(selectedRegions.containsLocalGovernment(region) ?
                                        selectionBackgroundColor : .white)
                            }
                            .id(region.id)
                        }
                    }
                }
                .onAppear {
                    if let selectedBasicLocalGovernment = selectedRegions.first?.basicLocalGovernment {
                        proxy.scrollTo(selectedBasicLocalGovernment.id, anchor: .center)
                    }
                }
            }
        }
    }

    // MARK: Private Methods

    private func didSelectedLocalGovernment(_ localGovernment: BasicLocalGovernment) {
        let selectedRegion = Region(
            regionalLocalGovernment: selectedRegionalLocalGovernment,
            basicLocalGovernment: localGovernment
        )
        if canMultiSelect {
            if selectedRegions.containsLocalGovernment(localGovernment) {
                selectedRegions.removeAll(where: { $0.basicLocalGovernment == localGovernment })

                #if DEBUG
                UmpaLogger(category: .component).log(
                    "\(String(describing: type(of: self))) : \(selectedRegion.description) 선택 해제됨",
                    level: .debug
                )
                #endif
            } else {
                selectedRegions.append(selectedRegion)

                #if DEBUG
                UmpaLogger(category: .component).log(
                    "\(String(describing: type(of: self))) : \(selectedRegion.description) 추가됨",
                    level: .debug
                )
                #endif
            }
        } else {
            selectedRegions = [selectedRegion]

            #if DEBUG
            UmpaLogger(category: .component).log(
                "\(String(describing: type(of: self))) : \(selectedRegion.description) 선택됨",
                level: .debug
            )
            #endif
        }
    }

    /// `regionList`를 정렬하여 반환합니다. 앱 시작 시 `regionList`가 반드시 초기화 된다고 가정합니다.
    private static func getSortedRegionalLocalGovernmentList() -> [RegionalLocalGovernment] {
        let regionalLocalGovernmentListOrder: [String: Int] = [
            "서울": 0,
            "인천": 1,
            "부산": 2,
            "대구": 3,
            "광주": 4,
            "대전": 5,
            "울산": 6,
            "세종": 7,
            "경기": 8,
            "강원": 9,
            "충북": 10,
            "충남": 11,
            "전북": 12,
            "전남": 13,
            "경북": 14,
            "경남": 15,
            "제주": 16
        ]
        let appData = Container.shared.appState.resolve().appData
        return appData.regionList.keys.sorted {
            regionalLocalGovernmentListOrder[$0] ?? Int.max < regionalLocalGovernmentListOrder[$1] ?? Int.max
        }
    }
}

private extension Array where Element == Region {
    func containsLocalGovernment(_ localGovernment: BasicLocalGovernment) -> Bool {
        contains { region in
            region.basicLocalGovernment == localGovernment
        }
    }
}

#Preview {
    @Previewable @State var selectedRegions: [Region] = []
    RegionSelector(selectedRegions: $selectedRegions, canMultiSelect: true)
}
