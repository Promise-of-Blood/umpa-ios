// Created for Umpa in 2025

import Foundation

struct Review: Identifiable {
    typealias Id = String

    let id: Id
    let created: Date
    let rating: Double
    let writer: Student.Id
    let contents: String
    let images: [URL?]
}

#if DEBUG
extension Review {
    static let sample0 = Review(
        id: "review0",
        created: .now,
        rating: 5.0,
        writer: "student0",
        contents:
        """
        선생님한테 정말 많은 걸 배웠습니다.
        그냥 음악적인 지식 뿐만 아니라 연습하는 루틴까지 체크해주시고 열정적으로 알려주셨습니다.
        의지 박약인 저를 합격 할 수 있게 해주신 은인 이십니당..
        """,
        images: []
    )

    static let sample1 = Review(
        id: "review1",
        created: .now,
        rating: 4.5,
        writer: "student1",
        contents:
        """
        개인 사정으로 잠깐 그만 두었지만 정말 좋은 선생님 이십니다.
        빡센 선생님 찾고 있었는데 정말 빡세게 알려주십니다.
        의지 박약인 사람한테 추천드려요
        """,
        images: []
    )
}
#endif
