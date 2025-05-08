// Created for Umpa in 2025

import Domain
import SwiftUI

struct LessonRegionSelectView: View {
    @Binding var selectedLessonRegions: [Region]

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: fs(14)) {
            selectedRegionChipList
            RegionSelector(selectedRegions: $selectedLessonRegions, canMultiSelect: true)
                .innerStroke(UmpaColor.lightGray, edges: .vertical)
                .clipped()
        }
    }

    var selectedRegionChipList: some View {
        Group {
            if selectedLessonRegions.isEmpty {
                Text("레슨 지역을 선택해 주세요")
                    .font(.pretendardRegular(size: fs(15)))
                    .foregroundStyle(UmpaColor.lightGray)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: fs(8)) {
                        ForEach(selectedLessonRegions, id: \.name) { region in
                            RegionChip(region: region, destructiveAction: {
                                withAnimation {
                                    selectedLessonRegions.removeAll { $0 == region }
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
        .animation(.default, value: selectedLessonRegions)
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
        return "\(regionalLocalGovernment) · \(basicLocalGovernment.name)"
    }
}

#Preview {
    @Previewable @State var selectedLessonRegions: [Region] = []

    LessonRegionSelectView(selectedLessonRegions: $selectedLessonRegions)
}
