// Created for Umpa in 2025

import Foundation

struct AcceptanceReview: Identifiable {
    typealias Id = String

    struct Comment {
        let contents: String
        let writer: User.Id
    }

    let id: Id

    let comments: [Comment]
}

#if DEBUG
extension AcceptanceReview {
    static let sample0 = AcceptanceReview(
        id: "acceptanceReview0",
        comments: [
            AcceptanceReview.Comment(contents: "와 정말 축하해요~~~~!!!!", writer: "user0"),
            AcceptanceReview.Comment(contents: "나도 합격하고 싶다...", writer: "user1"),
        ]
    )
}
#endif
