// Created for Umpa in 2025

import Components
import SwiftUI

struct MatchingDetailView: View {
    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    var content: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image("")
                title
//                LessonInfo()
//                PricePerTime(price: 100_000)
                HStack(spacing: 9) {
                    BadgeView("학력 인증")
                    BadgeView("시범 레슨 운영")
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            BottomActionBar()
                .padding()
        }
    }

    var title: some View {
        Text("가고싶은 학교 무조건 가는 방법")
    }
}

#Preview {
    NavigationStack {
        MatchingDetailView()
    }
}
