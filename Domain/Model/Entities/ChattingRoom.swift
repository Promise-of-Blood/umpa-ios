// Created for Umpa in 2025

import Foundation

public struct ChattingRoom: Identifiable, Hashable {
    public typealias Id = String

    public let id: Id?
    public let student: Student
    public let relatedService: AnyService
    public let messages: [ChatMessage]

    public init(id: Id?, student: Student, relatedService: AnyService, messages: [ChatMessage]) {
        self.id = id
        self.student = student
        self.relatedService = relatedService
        self.messages = messages
    }
}

public struct ChatMessage: Identifiable, Hashable {
    public typealias Id = String

    public let id: Id?
    public let created: Date
    public let sender: UserType
    public let text: String

    public init(id: Id?, created: Date, sender: UserType, text: String) {
        self.id = id
        self.created = created
        self.sender = sender
        self.text = text
    }
}
