// Created for Umpa in 2025

import Foundation

struct MentoringPost: Identifiable {
    typealias Id = String

    struct Comment: Identifiable {
        typealias Id = String

        let id: Id?
        let created: Date
        let contents: String
        let writer: Student.Id
    }

    let id: Id?
    let author: Teacher.Id
    let created: Date
    let title: String
    let contents: String
    let comments: [Comment]
}
