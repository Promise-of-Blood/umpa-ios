// Created for Umpa in 2025

import SwiftUI

struct ListContent: View {
    let model: ListContentModel

    var body: some View {
        VStack(spacing: 6) {
            Text(model.title)
                .font(.pretendardMedium(size: 12))
                .foregroundStyle(UmpaColor.darkGray)
                .lineLimit(1)
                .frame(maxWidth: .fill, alignment: .leading)
            HStack {
                Text(model.timeText)
                    .font(.pretendardRegular(size: 10))
                    .foregroundStyle(UmpaColor.mediumGray)
                Spacer()
                LikeCommentView(likeCount: model.likeCount, commentCount: model.commentCount)
            }
        }
        .frame(maxWidth: .fill)
    }
}

struct ListContentModel {
    let title: String
    let timeText: String
    let likeCount: Int
    let commentCount: Int

    #if DEBUG
    static let sample1 = ListContentModel(
        title: "제 9회 한국음악예술재단 주최 음파 경연대회 공모 요강 어서 빨리빨리!!!!",
        timeText: "25.03.16   09:24",
        likeCount: 512,
        commentCount: 131
    )

    static let sample2 = ListContentModel(
        title: "하루에 연습 몇시간 씩 하시나요?",
        timeText: "1분전",
        likeCount: 3,
        commentCount: 1
    )
    #endif
}

#Preview(traits: .sizeThatFitsLayout) {
    ListContent(model: .sample1)
        .frame(width: 300)
    ListContent(model: .sample2)
        .frame(width: 300)
}
