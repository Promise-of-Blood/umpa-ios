// Created for Umpa in 2025

import Foundation

struct Post: Identifiable {
    typealias Id = String

    enum Filter {
        case all
        case onlyQuestions
        case excludeQuestions
    }

    struct Comment {
        typealias Id = String

        let id: Id?
        let writer: User.Id?
        let created: Date
        let contents: String
    }

    let id: Id?
    let writer: User.Id?
    let created: Date
    let title: String
    let contents: String
    let images: [URL?]
    let likeCount: Int
    let comments: [Comment]
    let isQuestion: Bool
}

#if MOCK
extension Post {
    static let sample0 = Post(
        id: "post0",
        writer: "student0",
        created: .now,
        title: "오늘 선생님한테 엄청 혼났음",
        contents: "샘한테 비밀로하고 몰래 롤 다섯판하고왔는데 샘이 op.gg들어가서 전적 확인해서 들킴",
        images: [],
        likeCount: 32,
        comments: [
            .sample0,
        ],
        isQuestion: false
    )

    static let sample1 = Post(
        id: "post1",
        writer: "student0",
        created: .now,
        title: "하루에 연습 몇시간 씩 하시나요?",
        contents: "ㅈㄱㄴ",
        images: [],
        likeCount: 3,
        comments: [
            .sample1,
        ],
        isQuestion: true
    )
}

extension Post.Comment {
    static let sample0 = Post.Comment(
        id: "postComment0",
        writer: "student0",
        created: .now,
        contents: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"
    )

    static let sample1 = Post.Comment(
        id: "postComment1",
        writer: "student0",
        created: .now,
        contents: "하루에 12시간 정도 하는 것 같아요"
    )
}
#endif
