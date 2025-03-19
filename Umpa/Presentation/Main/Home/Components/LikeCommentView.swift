// Created for Umpa in 2025

import SwiftUI

struct LikeCommentView: View {
    let likeCount: Int
    let commentCount: Int

    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 6) {
                Image(.likeIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 11, height: 10)
                    .frame(width: 12, height: 12) // Icon frame
                Text("\(likeCount)")
                    .font(.pretendardRegular(size: 10))
                    .frame(width: 50, alignment: .leading)
                    .lineLimit(1)
            }
            .frame(width: 38, alignment: .leading)
            HStack(spacing: 6) {
                Image(.commentIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 10, height: 10)
                    .frame(width: 11, height: 12) // Icon frame
                Text("\(commentCount)")
                    .font(.pretendardRegular(size: 10))
                    .frame(width: 50, alignment: .leading)
            }
            .frame(width: 36, alignment: .leading)
        }
        .foregroundStyle(UmpaColor.mediumGray)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LikeCommentView(likeCount: 512, commentCount: 87)
}
