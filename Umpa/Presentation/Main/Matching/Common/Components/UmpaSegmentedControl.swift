// Created for Umpa in 2025

import SwiftUI

struct UmpaSegmentedControl: View {
    @Binding private var selection: Int

    let names: [String]
    let appearance: Appearance

    init(_ names: [String], selection: Binding<Int>, appearance: Appearance) {
        self.names = names
        self._selection = selection
        self.appearance = appearance
    }

    var body: some View {
        GeometryReader { proxy in
            let maximumButtonWidth = proxy.size.width / CGFloat(names.count)
            return HStack(spacing: 0) {
                IndexingForEach(names) { index, name in
                    Button(action: {
                        selection = index
                    }) {
                        VStack(spacing: appearance.bottomLineOffset) {
                            Text(name)
                                .font(appearance.font)
                                .fixedSize()
                                .foregroundStyle(index == selection ? appearance.activeColor : appearance.inactiveColor)
                            Rectangle()
                                .frame(height: appearance.bottomLineHeight)
                                .foregroundStyle(index == selection ? appearance.activeColor : Color.clear)
                        }
                        .frame(width: appearance.buttonWidth ?? maximumButtonWidth)
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

extension UmpaSegmentedControl {
    struct Appearance {
        /// 버튼의 너비를 지정하고 싶을 때 사용합니다. 지정하지 않으면 버튼의 너비는 가능한 크게 확장됩니다.
        let buttonWidth: CGFloat?

        /// 활성화된 탭에 적용할 색상입니다.
        let activeColor: Color

        /// 비활성화된 탭에 적용할 색상입니다.
        let inactiveColor: Color

        /// 활성화된 버튼을 강조하는 하단 라인의 높이입니다.
        let bottomLineHeight: CGFloat

        /// 활성화된 버튼을 강조하는 하단 라인의 Y축 오프셋입니다. 0이면 버튼 바로 아래에 위치하게 됩니다.
        let bottomLineOffset: CGFloat
        let font: Font

        func update(
            buttonWidth: (() -> CGFloat?)? = nil,
            activeColor: Color? = nil,
            inactiveColor: Color? = nil,
            bottomLineHeight: CGFloat? = nil,
            bottomLineOffset: CGFloat? = nil,
            font: Font? = nil
        ) -> Appearance {
            let _buttonWidth: CGFloat? = if let buttonWidth {
                buttonWidth()
            } else {
                nil
            }

            return Appearance(
                buttonWidth: _buttonWidth,
                activeColor: activeColor ?? self.activeColor,
                inactiveColor: inactiveColor ?? self.inactiveColor,
                bottomLineHeight: bottomLineHeight ?? self.bottomLineHeight,
                bottomLineOffset: bottomLineOffset ?? self.bottomLineOffset,
                font: font ?? self.font
            )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var index = 1

    let defaultAppearance = UmpaSegmentedControl.Appearance(
        buttonWidth: nil,
        activeColor: UmpaColor.main,
        inactiveColor: Color.black,
        bottomLineHeight: fs(2),
        bottomLineOffset: fs(12),
        font: .pretendardRegular(size: fs(14))
    )

    Text("커스텀 크기 지정")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.update(buttonWidth: { 70 }))
        .frame(width: 360)
        .padding()

    Text("버튼만 적절한 너비 지정")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.update(buttonWidth: { 70 }))
        .padding()

    Text("전체 적절한 너비 지정")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 360)
        .padding()

    Text("너비가 좁은 버튼")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.update(buttonWidth: { 60 }))
        .frame(width: 296)
        .padding()

    Text("좁은 전체 넓이")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 230)
        .padding()

    Text("너비 지정 안함")
    UmpaSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .padding()

    Text("갯수 3개")
    UmpaSegmentedControl([
        "선생님 소개",
        "반주 정보",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 280)
        .padding()
}
