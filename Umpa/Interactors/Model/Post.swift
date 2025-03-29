// Created for Umpa in 2025

import Foundation

struct Post: Identifiable {
    typealias Id = String

    enum Filter {
        case all
        case onlyQuestions
        case excludeQuestions
    }

    struct Comment {
        typealias Id = String

        let id: Id?
        let writer: User.Id?
        let created: Date
        let contents: String
    }

    let id: Id?
    let writter: User.Id?
    let created: Date
    let title: String
    let contents: String
    let images: [URL?]
    let likeCount: Int
    let comments: [Comment.Id]
}
