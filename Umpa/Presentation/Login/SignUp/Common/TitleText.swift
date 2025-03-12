// Created for Umpa in 2025

import SwiftUI

struct TitleText: ViewModifier {
    /// Modifies the provided view by applying title text styling.
    /// 
    /// This method sets a system font with a size of 28 and semibold weight, extends the view to fill the available horizontal space with leading alignment, and adds horizontal padding of 40 points along with top padding of 28 points.
    /// 
    /// - Parameter content: The view to which the title styling is applied.
    /// - Returns: A view incorporating the title-specific styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            .padding(.top, 28)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Text("앱의 이용 목적에 따라\n선택해주세요")
        .modifier(TitleText())
}
