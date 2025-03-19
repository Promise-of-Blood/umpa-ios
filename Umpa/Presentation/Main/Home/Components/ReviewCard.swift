// Created for Umpa in 2025

import SwiftUI

struct ReviewCard: View {
    let imageResource: ImageResource
    let title: String
    let likeCount: Int
    let commentCount: Int

    private let cornerRadius: CGFloat = 15
    private let imageHeight: CGFloat = 120
    private let contentWidth: CGFloat = 114

    var body: some View {
        content
            .padding(EdgeInsets(top: 1, leading: 1, bottom: 8, trailing: 1))
            .background(UmpaColor.baseColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(UmpaColor.baseColor, style: StrokeStyle(lineWidth: 1.25))
            }
    }

    var content: some View {
        VStack(spacing: 6) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: imageHeight)
            bottomContent
        }
        .frame(width: contentWidth)
    }

    var bottomContent: some View {
        VStack(spacing: 6) {
            Text(title)
                .foregroundStyle(UmpaColor.darkGray)
                .font(.pretendardMedium(size: 12))
                .lineLimit(2)
            LikeCommentView(likeCount: likeCount, commentCount: commentCount)
        }
        .padding(.horizontal, 10)
        .frame(width: .fill)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ScrollView(.horizontal) {
        HStack {
            Spacer(minLength: 20)
            ReviewCard(
                imageResource: ImageResource(name: "sample_image", bundle: .main),
                title: "장우영 선생님한테 수업 받고 입시 성공한 후기",
                likeCount: 17,
                commentCount: 5
            )
            ReviewCard(
                imageResource: ImageResource(name: "sample_image", bundle: .main),
                title: "장우영 선생님한테 수업 받고 입시 성공한 후기",
                likeCount: 17,
                commentCount: 5
            )
            ReviewCard(
                imageResource: ImageResource(name: "sample_image", bundle: .main),
                title: "장우영 선생님한테 수업 받고 입시 성공한 후기",
                likeCount: 17,
                commentCount: 5
            )
            ReviewCard(
                imageResource: ImageResource(name: "sample_image", bundle: .main),
                title: "장우영 선생님한테 수업 받고 입시 성공한 후기",
                likeCount: 17,
                commentCount: 5
            )
            Spacer(minLength: 20)
        }
    }
    .scrollIndicators(.hidden)
}
