// Created for Umpa in 2025

import SwiftUI

public struct BottomLineSegmentedControl: View {
    @Binding private var selection: Int

    let names: [String]
    let appearance: Appearance

    public init(_ names: [String], selection: Binding<Int>, appearance: Appearance? = nil) {
        self.names = names
        self._selection = selection
        self.appearance = appearance ?? Appearance()
    }

    public var body: some View {
        GeometryReader { proxy in
            let (buttonWidth, spacing) = calculateButtonWidthAndSpacing(proxy.size.width)
            return HStack(spacing: spacing) {
                ForEach(Array(zip(names.indices, names)), id: \.0) { index, name in
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
                        .frame(width: buttonWidth)
                    }
                    if case .value = appearance.buttonWidth,
                       let lastIndex = names.indices.last, index < lastIndex
                    {
                        Spacer(minLength: 0)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func calculateButtonWidthAndSpacing(_ parentWidth: CGFloat) -> (buttonWidth: CGFloat, spacing: CGFloat) {
        let spacing: CGFloat
        let width: CGFloat

        if let buttonWidth = appearance.buttonWidth {
            switch buttonWidth {
            case .value(let widthValue):
                width = widthValue
                spacing = 0
            case .spacing(let spacingValue):
                let totalSpacingWidth = spacingValue * CGFloat(names.count - 1)
                width = (parentWidth - totalSpacingWidth) / CGFloat(names.count)
                spacing = spacingValue
            }
        } else {
            width = parentWidth / CGFloat(names.count)
            spacing = 0
        }

        return (width, spacing)
    }
}

extension BottomLineSegmentedControl {
    public struct Appearance {
        /// 버튼의 너비를 지정하는 방법을 지정합니다.
        public enum Width {
            /// 버튼의 너비를 직접 지정합니다.
            case value(CGFloat)
            /// 버튼 사이의 간격을 지정하여 버튼의 너비를 결정합니다.
            case spacing(CGFloat)
        }

        /// 버튼의 너비를 지정하고 싶을 때 사용합니다. 지정하지 않으면 버튼의 너비는 가능한 크게 확장됩니다.
        public let buttonWidth: Width?

        /// 활성화된 탭에 적용할 색상입니다.
        public let activeColor: Color

        /// 비활성화된 탭에 적용할 색상입니다.
        public let inactiveColor: Color

        /// 활성화된 버튼을 강조하는 하단 라인의 높이입니다.
        public let bottomLineHeight: CGFloat

        /// 활성화된 버튼을 강조하는 하단 라인의 Y축 오프셋입니다. 0이면 버튼 바로 아래에 위치하게 됩니다.
        public let bottomLineOffset: CGFloat

        /// 버튼 텍스트의 폰트입니다.
        public let font: Font

        public init(
            buttonWidth: Width? = nil,
            activeColor: Color = .blue,
            inactiveColor: Color = .black,
            bottomLineHeight: CGFloat = 1.6,
            bottomLineOffset: CGFloat = 10,
            font: Font = .system(size: 14)
        ) {
            self.buttonWidth = buttonWidth
            self.activeColor = activeColor
            self.inactiveColor = inactiveColor
            self.bottomLineHeight = bottomLineHeight
            self.bottomLineOffset = bottomLineOffset
            self.font = font
        }

        public func updated(
            buttonWidth: (() -> Width?)? = nil,
            activeColor: Color? = nil,
            inactiveColor: Color? = nil,
            bottomLineHeight: CGFloat? = nil,
            bottomLineOffset: CGFloat? = nil,
            font: Font? = nil
        ) -> Appearance {
            let _buttonWidth: Width? = if let buttonWidth {
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

    let defaultAppearance = BottomLineSegmentedControl.Appearance(
        buttonWidth: nil,
        activeColor: Color(red: 0.4627, green: 0.8392, blue: 1.0),
        inactiveColor: Color.gray,
        bottomLineHeight: 2,
        bottomLineOffset: 12,
        font: .system(size: 14)
    )

    Text("커스텀 크기 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.updated(buttonWidth: { .value(70) }))
        .frame(width: 330)
        .padding()

    Text("버튼만 적절한 너비 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.updated(buttonWidth: { .value(70) }))
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
    ], selection: $index, appearance: defaultAppearance.updated(buttonWidth: { .value(60) }))
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

    Text("Spacing 지정")
    BottomLineSegmentedControl([
        "선생님 소개",
        "수업 소개",
        "커리큘럼",
        "리뷰",
    ], selection: $index, appearance: defaultAppearance.updated(buttonWidth: { .spacing(12) }))
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
    ], selection: $index)
        .padding()
}
