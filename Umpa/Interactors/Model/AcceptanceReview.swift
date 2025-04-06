// Created for Umpa in 2025

import Foundation

struct AcceptanceReview: Identifiable {
    typealias Id = String

    struct Comment: Identifiable {
        typealias Id = String

        let id: Id?
        let contents: String
        let writer: User.Id
    }

    let id: Id?
    let createdAt: Date
    let writer: Student
    let title: String
    let college: College
    let major: Major
    let images: [URL]
    let likeCount: Int
    let comments: [Comment]
    let taggedTeachers: [Teacher.Id]
}

#if MOCK
extension AcceptanceReview {
    static let sample0 = AcceptanceReview(
        id: "acceptanceReview0",
        createdAt: .now,
        writer: .sample0,
        title: "서울예대 작곡 합격 후기",
        college: College(name: "서울예술대학교"),
        major: Major(name: "피아노"),
        images: [],
        likeCount: 372,
        comments: [
            AcceptanceReview.Comment(
                id: "acceptanceReviewCommentId0",
                contents: "와 정말 축하해요~~~~!!!!",
                writer: "student0"
            ),
            AcceptanceReview.Comment(
                id: "acceptanceReviewCommentId1",
                contents: "나도 합격하고 싶다...",
                writer: "user1"
            ),
        ],
        taggedTeachers: ["teacher0"]
    )
}

extension AcceptanceReview.Comment {
    static let sample0 = AcceptanceReview.Comment(
        id: "acceptanceReviewComment0",
        contents: "ㅊㅊㅊㅊㅊㅊㅊㅊㅊ",
        writer: "student0"
    )

    static let sample1 = AcceptanceReview.Comment(
        id: "acceptanceReviewComment1",
        contents: "와 정말 축하해요~~~~!!!!",
        writer: "student0"
    )
}
#endif
