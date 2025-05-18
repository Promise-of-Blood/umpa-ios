// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct LikeCommentView: View {
  let likeCount: Int
  let commentCount: Int

  var body: some View {
    HStack(spacing: fs(10)) {
      HStack(spacing: fs(6)) {
        Image(.likeIcon)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: fs(11), height: fs(10))
          .frame(width: fs(12), height: fs(12)) // Icon frame
        Text("\(likeCount)")
          .font(.pretendardRegular(size: fs(10)))
          .frame(width: fs(50), alignment: .leading)
          .lineLimit(1)
      }
      .frame(width: fs(38), alignment: .leading)
      HStack(spacing: fs(6)) {
        Image(.commentIcon)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: fs(10), height: fs(10))
          .frame(width: fs(11), height: fs(12)) // Icon frame
        Text("\(commentCount)")
          .font(.pretendardRegular(size: fs(10)))
          .frame(width: fs(50), alignment: .leading)
      }
      .frame(width: fs(36), alignment: .leading)
    }
    .foregroundStyle(UmpaColor.mediumGray)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  LikeCommentView(likeCount: 512, commentCount: 87)
}
