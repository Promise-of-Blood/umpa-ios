// Created for Umpa in 2025

import SwiftUI

public struct ToggleSwitch: View {
  public struct Appearance {
    let enableForegroundColor: Color
    let disableForegroundColor: Color
    let enableBackgroundColor: Color
    let disableBackgroundColor: Color
    let circleRadius: CGFloat
    let rectangleSize: CGSize
    let rectangleCornerRadius: CGFloat
    let movingOffset: CGFloat

    public static let `default` = Appearance.fromDefault()

    public static func fromDefault(
      enableForegroundColor: Color = Color(hex: "0E2F6B"),
      disableForegroundColor: Color = UmpaColor.mediumGray,
      enableBackgroundColor: Color = UmpaColor.main,
      disableBackgroundColor: Color = UmpaColor.lightGray,
      circleRadius: CGFloat = fs(18),
      rectangleSize: CGSize = CGSize(width: fs(30), height: fs(12)),
      rectangleCornerRadius: CGFloat = fs(5),
      movingOffset: CGFloat = fs(6.5),
    ) -> Appearance {
      Appearance(
        enableForegroundColor: enableForegroundColor,
        disableForegroundColor: disableForegroundColor,
        enableBackgroundColor: enableBackgroundColor,
        disableBackgroundColor: disableBackgroundColor,
        circleRadius: circleRadius,
        rectangleSize: rectangleSize,
        rectangleCornerRadius: rectangleCornerRadius,
        movingOffset: movingOffset,
      )
    }
  }

  @Binding var isOn: Bool

  private let appearance: Appearance

  @State private var isPressing = false

  /// 스와이프 효과를 적용하기 위해 시각적 상태를 저장하는 변수
  ///
  /// 스와이프 제스처가 끝나면 `isOn`과 동기화됩니다. 스와이프 제스처 중에는 `isOn`과 다를 수 있습니다.
  @State private var visualIsOn: Bool

  private let animationDuration: CGFloat = 0.25
  private let stretchingWidth: CGFloat = fs(2.0)

  private var stretchAdjustingOffset: CGFloat {
    let adjustingOffset = stretchingWidth / 2.0
    if !visualIsOn, isPressing {
      return adjustingOffset
    }
    if visualIsOn, isPressing {
      return -adjustingOffset
    }
    return 0
  }

  public init(isOn: Binding<Bool>, appearance: Appearance = .default) {
    _isOn = isOn
    _visualIsOn = State(wrappedValue: isOn.wrappedValue)
    self.appearance = appearance
  }

  // MARK: View

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
        .foregroundStyle(visualIsOn ? appearance.enableBackgroundColor : appearance.disableBackgroundColor)
        .animation(.easeOut(duration: animationDuration), value: visualIsOn)
      Capsule()
        .frame(
          width: isPressing ? appearance.circleRadius + stretchingWidth : appearance.circleRadius,
          height: appearance.circleRadius
        )
        .foregroundStyle(visualIsOn ? appearance.enableForegroundColor : appearance.disableForegroundColor)
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
                // 켜진 상태에서 왼쪽으로 충분히 스와이프하면 시각적으로 꺼짐
                if gesture.translation.width < -stateChangeThreshold {
                  visualIsOn = false
                }
                // 켜진 상태에서 왼쪽으로 약간만 스와이프하면 켜진 상태 유지
                else if gesture.translation.width > -stateReturnThreshold {
                  visualIsOn = true
                }
              } else {
                // 꺼진 상태에서 오른쪽으로 충분히 스와이프하면 시각적으로 켜짐
                if gesture.translation.width > stateChangeThreshold {
                  visualIsOn = true
                }
                // 꺼진 상태에서 오른쪽으로 약간만 스와이프하면 꺼진 상태 유지
                else if gesture.translation.width < stateReturnThreshold {
                  visualIsOn = false
                }
              }
            }
            .onEnded { _ in
              // 제스처가 끝나면 시각적 상태를 실제 상태에 적용
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
