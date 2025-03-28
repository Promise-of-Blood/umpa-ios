// Created for Umpa in 2025

import Foundation

struct ChattingRoom: Identifiable {
    typealias Id = String

    let id: Id?
    let student: Student.Id
    let relatedService: ServiceId
    let messages: [ChatMessage.Id]
}

struct ChatMessage: Identifiable {
    typealias Id = String

    let id: Id?
    let created: Date
    let sender: UserType
    let text: String
}

#if DEBUG
extension ChattingRoom {
    static let sample0 = ChattingRoom(
        id: "chattingRoom0",
        student: "student0",
        relatedService: "lessonService0",
        messages: [
            "chatMessage0",
            "chatMessage1",
            "chatMessage2",
            "chatMessage3",
            "chatMessage4",
            "chatMessage5",
            "chatMessage6",
        ]
    )
}

extension ChatMessage {
    static let sample0 = ChatMessage(
        id: "chatMessage0",
        created: .now,
        sender: .student,
        text: "안녕하세요 선생님!"
    )

    static let sample1 = ChatMessage(
        id: "chatMessage1",
        created: .now,
        sender: .teacher,
        text: "안녕하세요 학생님!"
    )

    static let sample2 = ChatMessage(
        id: "chatMessage2",
        created: .now,
        sender: .student,
        text: "오늘은 무슨 곡을 배우나요?"
    )

    static let sample3 = ChatMessage(
        id: "chatMessage3",
        created: .now,
        sender: .teacher,
        text: "오늘은 스케일을 배워볼까요?"
    )

    static let sample4 = ChatMessage(
        id: "chatMessage4",
        created: .now,
        sender: .student,
        text: "네 알겠습니다!"
    )

    static let sample5 = ChatMessage(
        id: "chatMessage5",
        created: .now,
        sender: .teacher,
        text: "그럼 시작해볼까요?"
    )

    static let sample6 = ChatMessage(
        id: "chatMessage6",
        created: .now,
        sender: .student,
        text: "네!"
    )
}
#endif
