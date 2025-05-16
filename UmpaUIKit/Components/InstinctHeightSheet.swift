// Created for Umpa in 2025

import SwiftUI

/// `content`의 자체 크기에 맞춰서 높이를 조정하는 시트.
///
/// 화면에 보여지기 전에 자체 크기가 확정되어야 합니다.
public struct InstinctHeightSheet<Content: View>: View {
  @Binding var isPresenting: Bool

  let dismissAction: (() -> Void)?

  @ViewBuilder let content: () -> Content

  public init(isPresenting: Binding<Bool>, dismissAction: (() -> Void)? = nil, content: @escaping () -> Content) {
    _isPresenting = isPresenting
    self.dismissAction = dismissAction
    self.content = content
  }

  private let cornerRadius: CGFloat = 22
  private let animationDuration: TimeInterval = 0.22
  private let freeSpace: CGFloat = 30

  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .bottom) {
        dim
        content()
          .safeAreaPadding(.bottom, proxy.safeAreaInsets.bottom)
          .frame(height: isPresenting ? nil : 0, alignment: .top)
          .background(.background)
          .clipShape(.rect(topLeadingRadius: cornerRadius, topTrailingRadius: cornerRadius))
          .frame(
            maxHeight: isPresenting ? proxy.size.height - freeSpace : 0,
            alignment: .bottom
          )
          .background(.clear)
          .clipped()
      }
      .ignoresSafeArea()
      .animation(.easeOut(duration: animationDuration), value: isPresenting)
      .allowsHitTesting(isPresenting)
    }
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
