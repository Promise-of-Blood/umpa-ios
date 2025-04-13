// Created for Umpa in 2025

import Foundation

public struct Post: Identifiable {
    public enum Filter {
        case all
        case onlyQuestions
        case excludeQuestions
    }

    public struct Comment {
        public let id: String?
        public let writer: User.Id?
        public let created: Date
        public let content: String

        public init(id: String?, writer: User.Id?, created: Date, contents: String) {
            self.id = id
            self.writer = writer
            self.created = created
            self.content = contents
        }
    }

    public let id: String?
    public let writer: User.Id?
    public let created: Date
    public let title: String
    public let content: String
    public let images: [URL?]
    public let likeCount: Int
    public let comments: [Comment]
    public let isQuestion: Bool

    public init(
        id: String?,
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
        self.content = contents
        self.images = images
        self.likeCount = likeCount
        self.comments = comments
        self.isQuestion = isQuestion
    }
}
