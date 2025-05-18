// Created for Umpa in 2025

import Foundation

public struct Review: Identifiable, Hashable {
    public typealias Id = String

    public let id: Id?
    public let createdAt: Date
    public let rating: Rating
    public let writer: Student
    public let content: String
    public let images: [URL?]

    public init(
        id: Id?,
        createdAt: Date,
        rating: Rating,
        writer: Student,
        content: String,
        images: [URL?]
    ) {
        self.id = id
        self.createdAt = createdAt
        self.rating = rating
        self.writer = writer
        self.content = content
        self.images = images
    }
}
