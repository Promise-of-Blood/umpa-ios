// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct Card: View {
  let model: ReviewCardModel

  private let cornerRadius: CGFloat = fs(15)
  private let imageHeight: CGFloat = fs(120)
  private let contentWidth: CGFloat = fs(114)

  var body: some View {
    content
      .padding(EdgeInsets(top: fs(1), leading: fs(1), bottom: fs(8), trailing: fs(1)))
      .background(UmpaColor.baseColor)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .overlay {
        RoundedRectangle(cornerRadius: cornerRadius)
          .strokeBorder(UmpaColor.baseColor, style: StrokeStyle(lineWidth: fs(1.25)))
      }
  }

  var content: some View {
    VStack(spacing: fs(6)) {
      Image(model.imageResource)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: imageHeight)
      bottomContent
    }
    .frame(width: contentWidth)
  }

  var bottomContent: some View {
    VStack(spacing: fs(6)) {
      Text(model.title)
        .foregroundStyle(UmpaColor.darkGray)
        .font(.pretendardMedium(size: fs(12)))
        .lineLimit(2)
        .frame(maxWidth: .infinity, alignment: .leading)
      LikeCommentView(likeCount: model.likeCount, commentCount: model.commentCount)
    }
    .padding(.horizontal, fs(10))
    .frame(maxWidth: .infinity)
  }
}

struct ReviewCardModel {
  let imageResource: ImageResource
  let title: String
  let likeCount: Int
  let commentCount: Int

#if DEBUG
  static let sample1 = ReviewCardModel(
    imageResource: ImageResource(name: "sample_image", bundle: .main),
    title: "서울예대 최종 합격 후기",
    likeCount: 512,
    commentCount: 78
  )

  static let sample2 = ReviewCardModel(
    imageResource: ImageResource(name: "sample_image", bundle: .main),
    title: "장우영 선생님한테 수업 받고 입시 성공한 후기",
    likeCount: 17,
    commentCount: 5
  )
#endif
}

#if DEBUG
#Preview(traits: .sizeThatFitsLayout) {
  ScrollView(.horizontal) {
    HStack {
      Spacer(minLength: 20)
      Card(model: .sample1)
      Card(model: .sample2)
      Card(model: .sample1)
      Card(model: .sample2)
      Spacer(minLength: 20)
    }
  }
  .scrollIndicators(.hidden)
}
#endif
