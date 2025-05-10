// Created for Umpa in 2025

import SwiftUI

struct ScoreTypeSelectView: View {
    @Binding var selectedScoreTypes: Set<ScoreTypeFilter>

    let scoreTypeList: [ScoreTypeFilter]

    private let columnCount = 4
    private var rowCount: Int {
        Int(ceil(Double(scoreTypeList.count) / Double(columnCount)))
    }

    private var scoreTypeGridList: [[ScoreTypeFilter]] {
        var result: [[ScoreTypeFilter]] = []
        for i in 0 ..< rowCount {
            let startIndex = i * columnCount
            let endIndex = min(startIndex + columnCount, scoreTypeList.count)
            let subArray = Array(scoreTypeList[startIndex ..< endIndex])
            result.append(subArray)
        }
        return result
    }

    var body: some View {
        Grid(verticalSpacing: fs(30)) {
            ForEach(scoreTypeGridList, id: \.self) { row in
                GridRow {
                    ForEach(row, id: \.self) { scoreType in
                        ScoreTypeToggleButton(
                            scoreType: scoreType,
                            isSelected: selectedScoreTypes.contains(scoreType),
                            tapAction: {
                                didTapScoreTypeButton(scoreType: scoreType)
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    func didTapScoreTypeButton(scoreType: ScoreTypeFilter) {
        if selectedScoreTypes.contains(scoreType) {
            selectedScoreTypes.remove(scoreType)
        } else {
            selectedScoreTypes.insert(scoreType)
        }
    }
}

struct ScoreTypeToggleButton: View {
    let scoreType: ScoreTypeFilter
    let isSelected: Bool
    let tapAction: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    var body: some View {
        Button(action: tapAction) {
            VStack(spacing: fs(4)) {
                Image(scoreType.imageResource)
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

                Text(scoreType.name)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension ScoreTypeFilter {
    var name: String {
        switch self {
        case .fullScore:
            "풀 스코어"
        case .vocal:
            "보컬곡"
        case .piano:
            "피아노"
        case .guitar:
            "기타"
        case .bass:
            "베이스"
        case .windInstrument:
            "관악"
        case .drum:
            "드럼"
        }
    }

    var imageResource: ImageResource {
        ImageResource.seeAllIcon // FIXME: 실제 이미지 리소스 사용
    }
}

#Preview {
    @Previewable @State var selectedScoreTypes: Set<ScoreTypeFilter> = []

    ScoreTypeSelectView(selectedScoreTypes: $selectedScoreTypes, scoreTypeList: ScoreTypeFilter.allCases)
}
