// Created for Umpa in 2025

import Domain
import SwiftUI

struct InstrumentSelectView: View {
    @Binding var selectedInstruments: Set<InstrumentFilter>

    let instrumentList: [InstrumentFilter]

    private let columnCount = 4
    private var rowCount: Int {
        Int(ceil(Double(instrumentList.count) / Double(columnCount)))
    }

    private var instrumentGridList: [[InstrumentFilter]] {
        var result: [[InstrumentFilter]] = []
        for i in 0 ..< rowCount {
            let startIndex = i * columnCount
            let endIndex = min(startIndex + columnCount, instrumentList.count)
            let subArray = Array(instrumentList[startIndex ..< endIndex])
            result.append(subArray)
        }
        return result
    }

    var body: some View {
        Grid(verticalSpacing: fs(30)) {
            ForEach(instrumentGridList, id: \.self) { row in
                GridRow {
                    ForEach(row, id: \.self) { instrument in
                        InstrumentSelectionButton(
                            instrument: instrument,
                            isSelected: selectedInstruments.contains(instrument),
                            action: {
                                didTapInstrumentButton(instrument: instrument)
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    func didTapInstrumentButton(instrument: InstrumentFilter) {
        if selectedInstruments.contains(instrument) {
            selectedInstruments.remove(instrument)
        } else {
            selectedInstruments.insert(instrument)
        }
    }
}

struct InstrumentSelectionButton: View {
    let instrument: InstrumentFilter
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(4)) {
                Image(instrument.imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .padding(fs(12))
                    .background(isSelected ? UmpaColor.lightBlue : .white)
                    .innerRoundedStroke(
                        isSelected ? UmpaColor.mainBlue : UmpaColor.lightLightGray,
                        cornerRadius: iconCornerRadius,
                        lineWidth: fs(1.6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))

                Text(instrument)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension InstrumentFilter {
    var imageResource: ImageResource {
        ImageResource.seeAllIcon // FIXME: 실제 이미지 리소스 사용
    }
}

#Preview {
    @Previewable @State var selectedInstruments: Set<InstrumentFilter> = []

    InstrumentSelectView(
        selectedInstruments: $selectedInstruments,
        instrumentList: [
            "피아노",
            "보컬",
            "작곡",
            "드럼",
            "기타",
            "베이스",
            "관악",
        ],
    )
}
