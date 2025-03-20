// Created for Umpa in 2025

import SwiftUI

struct Badge: View {
    private let cornerRadius: CGFloat = fs(5)

    var body: some View {
        Text("태그 뱃찌")
            .font(.pretendardSemiBold(size: fs(11)))
            .foregroundStyle(Color(hex: "337AF7"))
            .padding(.horizontal, fs(10))
            .padding(.top, fs(5.5))
            .padding(.bottom, fs(4.5))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .innerStroke(UmpaColor.main, cornerRadius: cornerRadius)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Badge()
        .padding()
}
