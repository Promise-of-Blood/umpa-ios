// Created for Umpa in 2025

import Domain
import SwiftUI

struct HotPostsBanner: View {
    struct Model {
        let title: String
        let likeCount: Int
    }

    let hotPosts: [Model]

    @State private var currentIndex = 0

    var body: some View {
        HStack {
//            Image(.hotMark)
            Text(hotPosts[safe: currentIndex]?.title ?? "")
            Image(.likeIcon)
            Text(hotPosts[safe: currentIndex]?.likeCount.description ?? "")
        }
        .frame(maxWidth: .fill)
        .padding()
        .background(Color.red.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension AcceptanceReview {
    func toHotPostsBannerModel() -> HotPostsBanner.Model {
        HotPostsBanner.Model(title: title, likeCount: likeCount)
    }
}

extension Post {
    func toHotPostsBannerModel() -> HotPostsBanner.Model {
        HotPostsBanner.Model(title: title, likeCount: likeCount)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HotPostsBanner(hotPosts: [
        HotPostsBanner.Model(title: "3관왕 했습니다", likeCount: 161),
        HotPostsBanner.Model(title: "서울대 합격 후기", likeCount: 87),
    ])
}
