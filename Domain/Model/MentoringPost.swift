// Created for Umpa in 2025

import Foundation

public struct MentoringPost: Identifiable {
    public typealias Id = String

    public struct Comment: Identifiable {
        public typealias Id = String

        public let id: Id?
        public let created: Date
        public let contents: String
        public let writer: Student.Id

        public init(id: Id?, created: Date, contents: String, writer: Student.Id) {
            self.id = id
            self.created = created
            self.contents = contents
            self.writer = writer
        }
    }

    public let id: Id?
    public let author: Teacher.Id
    public let created: Date
    public let title: String
    public let contents: String
    public let comments: [Comment]

    public init(
        id: Id?,
        author: Teacher.Id,
        created: Date,
        title: String,
        contents: String,
        comments: [Comment]
    ) {
        self.id = id
        self.author = author
        self.created = created
        self.title = title
        self.contents = contents
        self.comments = comments
    }
}
