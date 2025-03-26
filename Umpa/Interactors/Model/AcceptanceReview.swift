// Created for Umpa in 2025

import Foundation

struct AcceptanceReview: Identifiable {
    typealias Id = String

    struct Comment {
        let contents: String
        let writer: User.Id
    }

    let id: Id

    let comments: [Comment]
}
