// Created for Umpa in 2025

import SwiftUI

struct BottomButton: ViewModifier {
    /// Applies bottom button styling to the given content.
    ///
    /// This modifier customizes the appearance of the view by setting a system font with a size of 22 and a medium weight, applying a white foreground style, and configuring a frame with an infinite maximum width and an ideal height of 71 while maintaining a fixed vertical size. It also overlays the content with a background color defined by `Color.main` in a rounded rectangle with a 12-point corner radius, and adds padding around the content.
    ///
    /// - Parameter content: The view to which the styling is applied.
    /// - Returns: A view with bottom button styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, idealHeight: 71)
            .fixedSize(horizontal: false, vertical: true)
            .background(Color.main, in: RoundedRectangle(cornerRadius: 12))
            .padding()
    }
}

#Preview {
    Text("Button")
        .modifier(BottomButton())
}
