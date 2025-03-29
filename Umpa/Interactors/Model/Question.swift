// Created for Umpa in 2025

import Foundation

@available(*, deprecated, message: "25/3/28(금) 기획에서 제거됨")
struct Question: Identifiable {
    typealias Id = String

    struct Comment: Identifiable {
        typealias Id = String

        let id: Id
        let writer: User.Id?
        let created: Date
        let contents: String
    }

    let id: Id
    let writer: User.Id?
    let created: Date
    let contents: String
    let image: URL?
    let record: Data?
    let comments: [Comment]
}

#if DEBUG
extension Question {
    static let sample0 = Question(
        id: "question0",
        writer: nil,
        created: .now,
        contents: "하루에 연습 몇시간 씩 하시나요?",
        image: nil,
        record: nil,
        comments: [
            Comment.sample0,
            Comment.sample1,
        ]
    )

    static let sample1 = Question(
        id: "question1",
        writer: nil,
        created: .now,
        contents: "연습하기 싫은데 롤 할까요 말까요?",
        image: nil,
        record: nil,
        comments: [
            Comment.sample2,
        ]
    )

    static let sample2 = Question(
        id: "question2",
        writer: nil,
        created: .now,
        contents: "이거 어떻게 쳐요?",
        image: nil,
        record: nil,
        comments: []
    )
}

extension Question.Comment {
    static let sample0 = Question.Comment(
        id: "questionComment0",
        writer: nil,
        created: .now,
        contents: "하루에 12시간 정도 하는 것 같아요"
    )

    static let sample1 = Question.Comment(
        id: "questionComment1",
        writer: nil,
        created: .now,
        contents: "팩트는 연습하는놈들은 이런거 올릴시간도 볼 시간도 없음 ㅇㄱㄹㅇ"
    )

    static let sample2 = Question.Comment(
        id: "questionComment2",
        writer: nil,
        created: .now,
        contents: "ㄱㄱ"
    )
}
#endif
