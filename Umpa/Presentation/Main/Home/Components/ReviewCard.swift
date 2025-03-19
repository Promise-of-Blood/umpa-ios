// Created for Umpa in 2025

import SwiftUI

struct ReviewCard: View {
    let title: String

    var body: some View {
        VStack {
            Text("리뷰")
                .font(.pretendardBold(size: 20))
        }
    }
}

#Preview {
    ReviewCard(title: "장우영 선생님한테 수업 받고 입시 성공한 후기")
}
