// Created for Umpa in 2025

import SwiftUI

struct BadgeView: View {
    let title: String

    private let cornerRadius: CGFloat = fs(5)

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.pretendardSemiBold(size: fs(11)))
            .foregroundStyle(Color(hex: "337AF7"))
            .padding(EdgeInsets(top: fs(5.5), leading: fs(10), bottom: fs(4.5), trailing: fs(10)))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .innerRoundedStroke(UmpaColor.main, cornerRadius: cornerRadius, lineWidth: fs(1))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BadgeView("태그 뱃찌")
        .padding()
    BadgeView("시범 레슨 운영")
        .padding()
}
