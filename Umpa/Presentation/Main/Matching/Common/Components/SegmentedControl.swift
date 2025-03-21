// Created for Umpa in 2025

import SwiftUI

struct SegmentedControl: View {
    @State private var currentIndex = 3

    private let selectedColor = UmpaColor.main

    let names: [String]
    let buttonWidth: CGFloat?

    init(_ names: [String], buttonWidth: CGFloat? = nil) {
        self.names = names
        self.buttonWidth = buttonWidth
        self.currentIndex = currentIndex
    }

    var body: some View {
        GeometryReader { proxy in
            let maximumButtonWidth = proxy.size.width / CGFloat(names.count)
            return HStack(spacing: 0) {
                ForEach(Array(zip(names.indices, names)), id: \.0) { index, name in
                    Button(action: {
                        currentIndex = index
                    }) {
                        VStack(spacing: fs(12)) {
                            Text(name)
                                .font(.pretendardRegular(size: fs(14)))
                                .fixedSize()
                                .foregroundStyle(index == currentIndex ? UmpaColor.main : Color.black)
                            Rectangle()
                                .frame(height: fs(2))
                                .foregroundStyle(index == currentIndex ? UmpaColor.main : Color.clear)
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
    Text("커스텀 크기 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], buttonWidth: 70)
        .frame(width: 360)
        .padding()

    Text("버튼만 적절한 너비 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], buttonWidth: 70)
        .padding()

    Text("전체 적절한 너비 지정")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ])
    .frame(width: 360)
    .padding()

    Text("너비가 좁은 버튼")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], buttonWidth: 60)
        .frame(width: 296)
        .padding()

    Text("좁은 전체 넓이")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ])
    .frame(width: 230)
    .padding()

    Text("너비 지정 안함")
    SegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ])
    .padding()

    Text("갯수 3개")
    SegmentedControl([
        "선생님 소개",
        "반주 정보",
        "리뷰",
    ])
    .frame(width: 280)
    .padding()
}
