// Created for Umpa in 2025

import SwiftUI

struct Badge: View {
    let title: String

    private let cornerRadius: CGFloat = fs(5)

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.pretendardSemiBold(size: fs(11)))
            .foregroundStyle(Color(hex: "337AF7"))
            .padding(.horizontal, fs(10))
            .padding(.top, fs(5.5))
            .padding(.bottom, fs(4.5))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .innerStroke(UmpaColor.main, cornerRadius: cornerRadius, lineWidth: fs(1))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Badge("태그 뱃찌")
        .padding()
    Badge("시범 레슨 운영")
        .padding()
}
