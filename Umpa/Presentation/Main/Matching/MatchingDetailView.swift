// Created for Umpa in 2025

import SwiftUI

struct MatchingDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("")
            title
            LessonInfo()
            PricePerTime(price: 100_000)
            HStack(spacing: 9) {
                Badge()
                Badge()
            }
            Spacer()
            BottomActionBar()
                .padding()
        }
        .padding(.horizontal, 30)
        .modifier(NavigationBackButton())
    }

    var title: some View {
        Text("가고싶은 학교 무조건 가는 방법")
    }
}

struct Badge: View {
    private let cornerRadius: CGFloat = 5

    var body: some View {
        Text("태그 뱃찌")
            .foregroundStyle(Color(hex: "337AF7"))
            .padding(.horizontal, 10)
            .padding(.top, 5.4)
            .padding(.bottom, 5.6)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color.main)
            }
    }
}

#Preview {
    NavigationStack {
        MatchingDetailView()
    }
}
