// Created for Umpa in 2025

import SwiftUI

public struct ToggleSwitch: View {
    struct Appearance {
        let circleRadius: CGFloat
        let circleColor: Color
        let rectangleSize: CGSize
        let rectangleCornerRadius: CGFloat
        let disabledColor: Color
        let enabledColor: Color
        let movingOffset: CGFloat

        static let `default` = Appearance(
            circleRadius: fs(18),
            circleColor: Color(hex: "0E2F6B"),
            rectangleSize: CGSize(width: fs(30), height: fs(12)),
            rectangleCornerRadius: fs(5),
            disabledColor: UmpaColor.lightGray,
            enabledColor: UmpaColor.main,
            movingOffset: fs(6.5)
        )
    }

    @Binding var isOn: Bool

    @State private var isPressing = false

    private let appearance: Appearance = .default

    private let animationDuration: CGFloat = 0.25
    private let stretchingWidth: CGFloat = fs(2.0)

    var stretchAdjustingOffset: CGFloat {
        let adjustingOffset = stretchingWidth / 2.0
        if !isOn && isPressing {
            return adjustingOffset
        }
        if isOn && isPressing {
            return -adjustingOffset
        }
        return 0
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: appearance.rectangleCornerRadius)
                .frame(width: appearance.rectangleSize.width, height: appearance.rectangleSize.height)
                .foregroundStyle(isOn ? appearance.enabledColor : appearance.disabledColor)
                .animation(.easeOut(duration: animationDuration), value: isOn)
            Capsule()
                .frame(
                    width: isPressing ? appearance.circleRadius + stretchingWidth : appearance.circleRadius,
                    height: appearance.circleRadius
                )
                .foregroundStyle(appearance.circleColor)
                .offset(x: stretchAdjustingOffset)
                .offset(x: isOn ? appearance.movingOffset : -appearance.movingOffset)
                .animation(.easeOut(duration: animationDuration), value: isOn)
                .animation(.easeOut(duration: animationDuration), value: isPressing)
        }
        .onTapGesture {
            isOn.toggle()
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressing = true
                }
                .onEnded { _ in
                    isPressing = false
                }
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var isOn1 = false
    @Previewable @State var isOn2 = true
    @Previewable @State var isOn3 = false
    @Previewable @State var isOn4 = true
    @Previewable @State var isOn5 = false

    ToggleSwitch(isOn: $isOn1)
        .padding(10)

    ToggleSwitch(isOn: $isOn2)
        .padding(20)
        .scaleEffect(2.0)

    ToggleSwitch(isOn: $isOn3)
        .padding(30)
        .scaleEffect(3.0)

    ToggleSwitch(isOn: $isOn4)
        .scaleEffect(4.0)
        .padding(40)

    HStack(spacing: fs(14)) {
        Text("ToggleSwitch")
        ToggleSwitch(isOn: $isOn5)
            .scaleEffect(1.2)
    }
    .padding()
}
