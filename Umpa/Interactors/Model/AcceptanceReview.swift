// Created for Umpa in 2025

import Foundation

struct AcceptanceReview: Identifiable {
    typealias Id = String

    struct Comment {
        let contents: String
        let writer: User.Id
    }

    let id: Id
    let created: Date
    let writer: Student.Id
    let title: String
    let school: School
    let major: Major
    let images: [URL]
    let likeCount: Int
    let comments: [Comment]
    let taggedTeachers: [Teacher.Id]
}

#if DEBUG
extension AcceptanceReview {
    static let sample0 = AcceptanceReview(
        id: "acceptanceReview0",
        created: .now,
        writer: "student0",
        title: "서울예대 작곡 합격 후기",
        school: School(name: "서울예술대학교"),
        major: Major(name: "피아노"),
        images: [],
        likeCount: 372,
        comments: [
            AcceptanceReview.Comment(contents: "와 정말 축하해요~~~~!!!!", writer: "user0"),
            AcceptanceReview.Comment(contents: "나도 합격하고 싶다...", writer: "user1"),
        ],
        taggedTeachers: ["teacher0"]
    )
}
#endif
