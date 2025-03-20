// Created for Umpa in 2025

import SwiftUI

struct LessonInfo: View {
    let teacher: String
    let rating: Double
    let region: String

    private let dotSize: CGFloat = fs(1.5)

    var ratingString: String {
        String(format: "%.1f", rating)
    }

    var body: some View {
        HStack(spacing: fs(4)) {
            Text(teacher)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.lightGray)
            spacingDot
            HStack(spacing: fs(3)) {
                Image(systemName: "star.fill") // TODO: 실제 리소스로 교체
                Text(ratingString)
                    .font(.pretendardSemiBold(size: fs(12)))
                    .foregroundStyle(Color.black)
            }
            spacingDot
            Text(region)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.lightGray)
        }
    }

    var spacingDot: some View {
        Circle()
            .frame(width: dotSize, height: dotSize)
            .foregroundStyle(UmpaColor.lightGray)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LessonInfo(
        teacher: "으음파 선생님",
        rating: 5.0,
        region: "음파/음파동"
    )
}
