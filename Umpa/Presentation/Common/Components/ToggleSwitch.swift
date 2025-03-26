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
    @State private var visualIsOn: Bool

    private let appearance: Appearance = .default

    private let animationDuration: CGFloat = 0.25
    private let stretchingWidth: CGFloat = fs(2.0)

    var stretchAdjustingOffset: CGFloat {
        let adjustingOffset = stretchingWidth / 2.0
        if !visualIsOn && isPressing {
            return adjustingOffset
        }
        if visualIsOn && isPressing {
            return -adjustingOffset
        }
        return 0
    }

    public init(isOn: Binding<Bool>) {
        _isOn = isOn
        _visualIsOn = State(wrappedValue: isOn.wrappedValue)
    }

    public var body: some View {
        content
            .onChange(of: isOn, initial: true) {
                visualIsOn = isOn
            }
            .onTapGesture {
                isOn.toggle()
            }
            .applyPressingGesture($isPressing)
            .applySwipeGesture(isOn: $isOn, visualIsOn: $visualIsOn, width: appearance.rectangleSize.width)
    }

    var content: some View {
        ZStack {
            RoundedRectangle(cornerRadius: appearance.rectangleCornerRadius)
                .frame(width: appearance.rectangleSize.width, height: appearance.rectangleSize.height)
                .foregroundStyle(visualIsOn ? appearance.enabledColor : appearance.disabledColor)
                .animation(.easeOut(duration: animationDuration), value: visualIsOn)
            Capsule()
                .frame(
                    width: isPressing ? appearance.circleRadius + stretchingWidth : appearance.circleRadius,
                    height: appearance.circleRadius
                )
                .foregroundStyle(appearance.circleColor)
                .offset(x: stretchAdjustingOffset)
                .offset(x: visualIsOn ? appearance.movingOffset : -appearance.movingOffset)
                .animation(.easeOut(duration: animationDuration), value: visualIsOn)
                .animation(.easeOut(duration: animationDuration), value: isPressing)
        }
    }
}

private extension ToggleSwitch {
    struct ApplyPressingGesture: ViewModifier {
        @Binding var isPressing: Bool

        func body(content: Content) -> some View {
            content
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

    struct ApplySwipeGesture: ViewModifier {
        @Binding var isOn: Bool
        @Binding var visualIsOn: Bool

        let width: CGFloat

        func body(content: Content) -> some View {
            content
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            let stateChangeThreshold = width * 0.7
                            let stateReturnThreshold = width * 0.2
                            if isOn {
                                if gesture.translation.width < -stateChangeThreshold {
                                    visualIsOn = false
                                } else if gesture.translation.width > -stateReturnThreshold {
                                    visualIsOn = true
                                }
                            } else {
                                if gesture.translation.width > stateChangeThreshold {
                                    visualIsOn = true
                                } else if gesture.translation.width < stateReturnThreshold {
                                    visualIsOn = false
                                }
                            }
                        }
                        .onEnded { _ in
                            isOn = visualIsOn
                        }
                )
        }
    }
}

private extension View {
    func applyPressingGesture(_ isPressing: Binding<Bool>) -> some View {
        modifier(ToggleSwitch.ApplyPressingGesture(isPressing: isPressing))
    }

    func applySwipeGesture(isOn: Binding<Bool>, visualIsOn: Binding<Bool>, width: CGFloat) -> some View {
        modifier(ToggleSwitch.ApplySwipeGesture(isOn: isOn, visualIsOn: visualIsOn, width: width))
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

    Toggle("Example Label", isOn: $isOn1)
        .padding(40)

    HStack(spacing: fs(14)) {
        Text("ToggleSwitch")
        ToggleSwitch(isOn: $isOn5)
            .scaleEffect(1.2)
    }
    .padding()
}
