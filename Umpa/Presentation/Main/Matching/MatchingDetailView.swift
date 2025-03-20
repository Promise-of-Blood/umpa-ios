// Created for Umpa in 2025

import SwiftUI
import UmpaComponents

struct MatchingDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image("")
                title
                LessonInfo()
                PricePerTime(price: 100_000)
                HStack(spacing: 9) {
                    Badge("학력 인증")
                    Badge("시범 레슨 운영")
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            BottomActionBar()
                .padding()
        }
        .modifier(NavigationBackButton(.arrowBack))
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
