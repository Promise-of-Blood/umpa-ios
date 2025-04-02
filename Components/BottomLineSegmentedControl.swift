// Created for Umpa in 2025

import SwiftUI

public struct BottomLineSegmentedControl: View {
    @Binding private var selection: Int

    let names: [String]
    let appearance: Appearance

    public init(_ names: [String], selection: Binding<Int>, appearance: Appearance) {
        self.names = names
        self._selection = selection
        self.appearance = appearance
    }

    public init(_ names: [String], selection: Binding<Int>, buttonWidth: CGFloat) {
        self.names = names
        self._selection = selection
        self.appearance = Appearance(buttonWidth: buttonWidth)
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(zip(names.indices, names)), id: \.0) { index, name in
                Button(action: {
                    selection = index
                }) {
                    VStack(spacing: appearance.bottomLineOffset) {
                        Text(name)
                            .font(index == selection ? appearance.activeFont : appearance.inactiveFont)
                            .fixedSize()
                            .foregroundStyle(index == selection ? appearance.activeColor : appearance.inactiveColor)
                        Rectangle()
                            .frame(height: appearance.bottomLineHeight)
                            .foregroundStyle(index == selection ? appearance.activeColor : Color.clear)
                    }
                    .frame(width: appearance.buttonWidth)
                }
                if let lastIndex = names.indices.last, index < lastIndex {
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

extension BottomLineSegmentedControl {
    public struct Appearance {
        /// 버튼의 너비를 지정합니다.
        ///
        /// `GeometryReader` 사용을 피하기 위해 필수로 버튼의 너비를 지정해야 합니다.
        public let buttonWidth: CGFloat

        /// 활성화된 탭에 적용할 색상입니다.
        public let activeColor: Color

        /// 비활성화된 탭에 적용할 색상입니다.
        public let inactiveColor: Color

        /// 활성화된 버튼을 강조하는 하단 라인의 높이입니다.
        public let bottomLineHeight: CGFloat

        /// 활성화된 버튼을 강조하는 하단 라인의 Y축 오프셋입니다. 0이면 버튼 바로 아래에 위치하게 됩니다.
        public let bottomLineOffset: CGFloat

        /// 활성화된 버튼의 폰트입니다.
        public let activeFont: Font

        /// 비활성화된 버튼의 폰트입니다.
        public let inactiveFont: Font

        init(
            buttonWidth: CGFloat,
            activeColor: Color = .blue,
            inactiveColor: Color = .black,
            bottomLineHeight: CGFloat = 1.6,
            bottomLineOffset: CGFloat = 10,
            activeFont: Font = .system(size: 14, weight: .medium),
            inactiveFont: Font = .system(size: 14, weight: .regular)
//            font: Font = .system(size: 14)
        ) {
            self.buttonWidth = buttonWidth
            self.activeColor = activeColor
            self.inactiveColor = inactiveColor
            self.bottomLineHeight = bottomLineHeight
            self.bottomLineOffset = bottomLineOffset
            self.activeFont = activeFont
            self.inactiveFont = inactiveFont
        }

        public static func appearance(
            buttonWidth: CGFloat,
            activeColor: Color = .blue,
            inactiveColor: Color = .black,
            bottomLineHeight: CGFloat = 1.6,
            bottomLineOffset: CGFloat = 10,
            activeFont: Font = .system(size: 14, weight: .medium),
            inactiveFont: Font = .system(size: 14, weight: .regular)
        ) -> Appearance {
            Appearance(
                buttonWidth: buttonWidth,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                bottomLineHeight: bottomLineHeight,
                bottomLineOffset: bottomLineOffset,
                activeFont: activeFont,
                inactiveFont: inactiveFont
            )
        }

        public func updated(
            buttonWidth: CGFloat? = nil,
            activeColor: Color? = nil,
            inactiveColor: Color? = nil,
            bottomLineHeight: CGFloat? = nil,
            bottomLineOffset: CGFloat? = nil,
            activeFont: Font? = nil,
            inactiveFont: Font? = nil
        ) -> Appearance {
            Appearance(
                buttonWidth: buttonWidth ?? self.buttonWidth,
                activeColor: activeColor ?? self.activeColor,
                inactiveColor: inactiveColor ?? self.inactiveColor,
                bottomLineHeight: bottomLineHeight ?? self.bottomLineHeight,
                bottomLineOffset: bottomLineOffset ?? self.bottomLineOffset,
                activeFont: activeFont ?? self.activeFont,
                inactiveFont: inactiveFont ?? self.inactiveFont
            )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var index = 1

    let defaultAppearance = BottomLineSegmentedControl.Appearance(
        buttonWidth: 70,
        activeColor: Color(red: 0.4627, green: 0.8392, blue: 1.0),
        inactiveColor: Color.gray,
        bottomLineHeight: 2,
        bottomLineOffset: 12,
        activeFont: .system(size: 14, weight: .medium),
        inactiveFont: .system(size: 14, weight: .regular)
    )

    Text("커스텀 크기 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 330)
        .padding()

    Text("버튼만 적절한 너비 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .padding()

    Text("전체 적절한 너비 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 360)
        .padding()

    Text("너비가 좁은 버튼")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.updated(buttonWidth: 50))
        .frame(width: 296)
        .padding()

    Text("좁은 전체 넓이")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 230)
        .padding()

    Text("너비 지정 안함")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .padding()

    Text("갯수 3개")
    BottomLineSegmentedControl([
        "선생님 소개",
        "반주 정보",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance)
        .frame(width: 280)
        .padding()

    Text("Default Appearance")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, buttonWidth: 70)
        .padding()
}
