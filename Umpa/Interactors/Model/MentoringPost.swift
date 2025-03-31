// Created for Umpa in 2025

import Foundation

struct MentoringPost: Identifiable {
    typealias Id = String

    struct Comment: Identifiable {
        typealias Id = String

        let id: Id?
        let created: Date
        let contents: String
        let writer: Student.Id
    }

    let id: Id?
    let author: Teacher.Id
    let created: Date
    let title: String
    let contents: String
    let comments: [Comment]
}

#if MOCK
extension MentoringPost {
    static let sample0 = MentoringPost(
        id: "mentoringPost0",
        author: "teacher0",
        created: .now,
        title: "실용음악 입시생이라면 누구나 알고 있는 앨범 10개",
        contents:
        """
        안녕하세요! 
        작곡 선생님 이수빈 입니다.
        오늘은 꼭 알고있으면 좋을 앨범에 대해서 소개 하려고 합니다.
        ...
        """,
        comments: [
            .sample0,
        ]
    )
}

extension MentoringPost.Comment {
    static let sample0 = MentoringPost.Comment(
        id: "mentoringPostComment0",
        created: .now,
        contents: "너무 좋은 글이네요",
        writer: "student0"
    )
}
#endif
