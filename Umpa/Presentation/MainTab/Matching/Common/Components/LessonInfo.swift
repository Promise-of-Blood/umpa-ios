// Created for Umpa in 2025

import SwiftUI

struct LessonInfo: View {
    struct Model {
        let teacher: String
        let rating: Double
        let region: String
    }

    let model: Model

    private let dotSize: CGFloat = fs(1.5)

    var body: some View {
        HStack(spacing: fs(4)) {
            Text(model.teacher)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.lightGray)
                .lineLimit(1)
                .layoutPriority(2)
            spacingDot
            StarRating(model.rating)
                .layoutPriority(1)
            spacingDot
            Text(model.region)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.lightGray)
                .lineLimit(1)
        }
    }

    var spacingDot: some View {
        Circle()
            .frame(width: dotSize, height: dotSize)
            .foregroundStyle(UmpaColor.lightGray)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LessonInfo(model: .example0)
        .frame(width: 160)
        .border(Color.black)
        .padding()
        .border(Color.black)
    LessonInfo(model: .example1)
        .border(Color.black)
        .padding()
        .border(Color.black)
    LessonInfo(model: .example2)
        .border(Color.black)
        .padding()
        .border(Color.black)
}

#if DEBUG
extension LessonInfo.Model {
    static let example0 = LessonInfo.Model(
        teacher: "으음파 선생님",
        rating: 5.0,
        region: "충남 금산/금산읍"
    )

    static let example1 = LessonInfo.Model(
        teacher: "김현지 선생님",
        rating: 3.2,
        region: "음파/음파동"
    )

    static let example2 = LessonInfo.Model(
        teacher: "힝꾸 선생님",
        rating: 4.0,
        region: "안산/고양이동"
    )
}
#endif
