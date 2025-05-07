// Created for Umpa in 2025

import SwiftUI

public struct InstinctSheet<Content: View>: View {
    @Binding var isPresenting: Bool
    
    let dismissAction: (() -> Void)?
    
    @ViewBuilder let content: () -> Content
    
    public init(isPresenting: Binding<Bool>, dismissAction: (() -> Void)? = nil, content: @escaping () -> Content) {
        self._isPresenting = isPresenting
        self.dismissAction = dismissAction
        self.content = content
    }
    
    private let cornerRadius: CGFloat = 22
    private let animationDuration: TimeInterval = 0.25
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                dim
                content()
                    .safeAreaPadding(.bottom, proxy.safeAreaInsets.bottom)
                    .frame(height: isPresenting ? nil : 0, alignment: .bottom)
                    .background(.background)
                    .clipShape(.rect(topLeadingRadius: cornerRadius, topTrailingRadius: cornerRadius))
                    .clipped()
            }
            .ignoresSafeArea()
            .animation(.easeInOut(duration: animationDuration), value: isPresenting)
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

#Preview {
    @Previewable @State var isPresenting = false
    
    ZStack {
        Button(action: {
            isPresenting = true
        }) {
            Text("Show Sheet")
        }
        
        InstinctSheet(isPresenting: $isPresenting) {
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
