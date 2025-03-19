// Created for Umpa in 2025

import SwiftUI

struct SeeAllButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 5) {
                Text("전체보기")
                    .font(.pretendardMedium(size: 10))
                Image(.customChevronRight)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 6, height: 9)
            }
            .foregroundStyle(UmpaColor.darkGray)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SeeAllButton()
}
