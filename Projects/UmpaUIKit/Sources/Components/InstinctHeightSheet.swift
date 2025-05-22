// Created for Umpa in 2025

import SwiftUI

/// `content`의 자체 크기에 맞춰서 높이를 조정하는 시트.
///
/// 화면에 보여지기 전에 자체 크기가 확정되어야 합니다.
public struct InstinctHeightSheet<Content: View>: View {
  @Binding var isPresenting: Bool

  /// 시트 밖을 탭하거나 시트를 내려서 닫을 때 호출됩니다.
  let dismissAction: (() -> Void)?

  @ViewBuilder let content: () -> Content

  // 드래그 상태를 위한 변수 추가
  @State private var dragOffset: CGFloat = .zero
  @State private var contentHeight: CGFloat = .zero // 컨텐츠의 실제 높이를 저장하기 위한 변수

  public init(
    isPresenting: Binding<Bool>,
    dismissAction: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _isPresenting = isPresenting
    self.dismissAction = dismissAction
    self.content = content
  }

  private let cornerRadius: CGFloat = 22
  private let animationDuration: TimeInterval = 0.22
  /// 드래그 시 시트가 닫히는 높이를 결정하는 높이 계수.
  private let closeDragThresholdRatio: CGFloat = 0.5
  /// 시트를 튕겼을 때 얼마나 쉽게 닫히는지 결정하는 값. 낮을 수록 쉽게 닫힘.
  private let flickForceThreshold: CGFloat = 180

  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .bottom) {
        dim
        sheetContent(proxy: proxy)
      }
      .ignoresSafeArea()
      .animation(.interpolatingSpring(stiffness: 300, damping: 30), value: isPresenting)
      .animation(.interpolatingSpring(stiffness: 300, damping: 30), value: dragOffset)
      .allowsHitTesting(isPresenting)
      .onChange(of: isPresenting) { _, newValue in // isPresenting이 false로 바뀔 때 dragOffset 초기화
        if !newValue {
          dragOffset = .zero
        }
      }
    }
  }

  @ViewBuilder
  private func sheetContent(proxy: GeometryProxy) -> some View {
    content()
      .background(
        GeometryReader { contentProxy in
          Color.clear
            .onChange(of: contentProxy.size.height, initial: true) { _, newHeight in
              // 컨텐츠 높이가 처음 결정되거나 변경될 때 업데이트
              contentHeight = newHeight
            }
        }
      )
      .safeAreaPadding(.bottom, proxy.safeAreaInsets.bottom)
      .frame(height: isPresenting ? nil : 0, alignment: .top) // 기본 높이 로직 유지
      .background(.background)
      .clipShape(.rect(topLeadingRadius: cornerRadius, topTrailingRadius: cornerRadius))
      .offset(y: dragOffset > 0 ? dragOffset : 0) // 아래로만 드래그 되도록, dragOffset 적용
      .gesture(
        DragGesture()
          .onChanged { value in
            // 아래로 드래그하는 경우에만 오프셋 변경
            if value.translation.height > 0 {
              dragOffset = value.translation.height
            }
          }
          .onEnded { value in
            let verticalDragDistance = value.translation.height
            let flickForce = value.predictedEndTranslation.height - verticalDragDistance // 단순화된 수직 속도 근사치

            // 1. 드래그 거리가 컨텐츠 높이의 일정 비율을 넘거나
            // 2. 아래로 빠르게 flick 했을 경우 닫기
            if verticalDragDistance > contentHeight * closeDragThresholdRatio || flickForce > flickForceThreshold {
              isPresenting = false
              dismissAction?()
              // dragOffset은 isPresenting의 onChange에서 초기화됨
            } else {
              // 그 외의 경우에는 원래 위치로 복귀
              dragOffset = .zero
            }
          }
      )
      .frame(
        maxHeight: isPresenting ? proxy.size.height : 0,
        alignment: .bottom
      )
      .clipped() // 시트 뒤 화면을 완전히 가리지 않도록 자름
  }

  var dim: some View {
    Color.black.opacity(0.3)
      .opacity(isPresenting ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresenting = false
          dismissAction?()
        }
      }
  }
}

#Preview("기본") {
  @Previewable @State var isPresenting = false

  ZStack {
    Button(action: {
      isPresenting = true
    }) {
      Text("Show Sheet")
    }

    InstinctHeightSheet(isPresenting: $isPresenting) {
      VStack {
        Text("Top")
        Spacer()
        Text("Bottom")
      }
      .frame(maxWidth: .infinity, idealHeight: 370)
      .fixedSize(horizontal: false, vertical: true)
    }
  }
}

#Preview("초과 높이") {
  @Previewable @State var isPresenting = false

  ZStack {
    Button(action: {
      isPresenting = true
    }) {
      Text("Show Sheet")
    }

    InstinctHeightSheet(isPresenting: $isPresenting) {
      VStack {
        Text("Top")
        Spacer()
        Text("Bottom")
      }
      .frame(maxWidth: .infinity, idealHeight: 1000)
      .fixedSize(horizontal: false, vertical: true)
    }
  }
}

#Preview("버튼 상단") {
  @Previewable @State var isPresenting = false

  VStack {
    InstinctHeightSheet(isPresenting: $isPresenting) {
      VStack {
        Text("Top")
        Spacer()
        Text("Bottom")
      }
      .frame(maxWidth: .infinity, idealHeight: 300)
      .fixedSize(horizontal: false, vertical: true)
      .background(.yellow)
    }

    Button(action: {
      isPresenting = true
    }) {
      Text("Show Sheet")
    }
  }
}

// #Preview("버튼 하단") {
//  @Previewable @State var isPresenting = false
//
//  VStack {
//    Button(action: {
//      isPresenting = true
//    }) {
//      Text("Show Sheet")
//    }
//
//    InstinctHeightSheet(isPresenting: $isPresenting) {
//      VStack {
//        Text("Top")
//        Spacer()
//        Text("Bottom")
//      }
//      .frame(maxWidth: .infinity, idealHeight: 300)
//      .fixedSize(horizontal: false, vertical: true)
//      .background(.yellow)
//    }
//  }
// }

#Preview("Built-in Sheet") {
  @Previewable @State var isPresenting = false

  Button(action: {
    isPresenting = true
  }) {
    Text("Show Sheet")
  }
  .sheet(isPresented: $isPresenting) {
    VStack {
      Text("Top")
      Spacer()
      Text("Bottom")
    }
    .frame(maxWidth: .infinity)
    .background(.yellow)
  }
}
