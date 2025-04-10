// Created for Umpa in 2025

import Foundation

public struct Post: Identifiable {
    public typealias Id = String

    public enum Filter {
        case all
        case onlyQuestions
        case excludeQuestions
    }

    public struct Comment {
        public typealias Id = String

        public let id: Id?
        public let writer: User.Id?
        public let created: Date
        public let contents: String

        public init(id: Id?, writer: User.Id?, created: Date, contents: String) {
            self.id = id
            self.writer = writer
            self.created = created
            self.contents = contents
        }
    }

    public let id: Id?
    public let writer: User.Id?
    public let created: Date
    public let title: String
    public let contents: String
    public let images: [URL?]
    public let likeCount: Int
    public let comments: [Comment]
    public let isQuestion: Bool

    public init(
        id: Id?,
        writer: User.Id?,
        created: Date,
        title: String,
        contents: String,
        images: [URL?],
        likeCount: Int,
        comments: [Comment],
        isQuestion: Bool
    ) {
        self.id = id
        self.writer = writer
        self.created = created
        self.title = title
        self.contents = contents
        self.images = images
        self.likeCount = likeCount
        self.comments = comments
        self.isQuestion = isQuestion
    }
}
