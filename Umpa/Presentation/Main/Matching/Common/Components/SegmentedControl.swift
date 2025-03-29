// Created for Umpa in 2025

import SwiftUI

struct SegmentedControl: View {
    @Binding private var selection: Int

    private let selectedColor = UmpaColor.main

    let names: [String]
    let buttonWidth: CGFloat?

    init(_ names: [String], selection: Binding<Int>, buttonWidth: CGFloat? = nil) {
        self.names = names
        self.buttonWidth = buttonWidth
        self._selection = selection
    }

    var body: some View {
        GeometryReader { proxy in
            let maximumButtonWidth = proxy.size.width / CGFloat(names.count)
            return HStack(spacing: 0) {
                IndexingForEach(names) { index, name in
                    Button(action: {
                        selection = index
                    }) {
                        VStack(spacing: fs(12)) {
                            Text(name)
                                .font(.pretendardRegular(size: fs(14)))
                                .fixedSize()
                                .foregroundStyle(index == selection ? UmpaColor.main : Color.black)
                            Rectangle()
                                .frame(height: fs(2))
                                .foregroundStyle(index == selection ? UmpaColor.main : Color.clear)
                        }
                        .frame(width: buttonWidth ?? maximumButtonWidth)
                    }
                    if let lastIndex = names.indices.last, index < lastIndex {
                        Spacer(minLength: 0)
                    }
                }
            }
            .frame(maxWidth: .fill)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var index = 1

    Text("커스텀 크기 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, buttonWidth: 70)
        .frame(width: 360)
        .padding()

    Text("버튼만 적절한 너비 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, buttonWidth: 70)
        .padding()

    Text("전체 적절한 너비 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index)
        .frame(width: 360)
        .padding()

    Text("너비가 좁은 버튼")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, buttonWidth: 60)
        .frame(width: 296)
        .padding()

    Text("좁은 전체 넓이")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index)
        .frame(width: 230)
        .padding()

    Text("너비 지정 안함")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index)
        .padding()

    Text("갯수 3개")
    SegmentedControl([
        "선생님 소개",
        "반주 정보",
        "리뷰",
    ], selection: $index)
        .frame(width: 280)
        .padding()
}
