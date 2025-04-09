// Created for Umpa in 2025

import Foundation

public struct AcceptanceReview: Identifiable, Hashable {
    public typealias Id = String

    public struct Comment: Identifiable, Hashable {
        public typealias Id = String

        public let id: Id?
        public let contents: String
        public let writer: User.Id

        public init(id: Id?, contents: String, writer: User.Id) {
            self.id = id
            self.contents = contents
            self.writer = writer
        }
    }

    public let id: Id?
    public let createdAt: Date
    public let writer: Student
    public let title: String
    public let college: College
    public let major: Major
    public let images: [URL]
    public let likeCount: Int
    public let comments: [Comment]
    public let taggedTeachers: [Teacher.Id]

    public init(
        id: Id?,
        createdAt: Date,
        writer: Student,
        title: String,
        college: College,
        major: Major,
        images: [URL],
        likeCount: Int,
        comments: [Comment],
        taggedTeachers: [Teacher.Id]
    ) {
        self.id = id
        self.createdAt = createdAt
        self.writer = writer
        self.title = title
        self.college = college
        self.major = major
        self.images = images
        self.likeCount = likeCount
        self.comments = comments
        self.taggedTeachers = taggedTeachers
    }
}
