// Created for Umpa in 2025

import Foundation

struct Question: Identifiable {
    typealias Id = String

    struct Comment: Identifiable {
        typealias Id = String

        let id: Id
        let writer: User.Id?
        let created: Date
        let contents: String
    }

    let id: Id
    let writer: User.Id?
    let created: Date
    let contents: String
    let image: URL
    let record: Data
    let comments: [Comment]
}
