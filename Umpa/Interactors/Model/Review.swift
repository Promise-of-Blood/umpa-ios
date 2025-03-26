// Created for Umpa in 2025

import Foundation

struct Review: Identifiable {
    typealias Id = String

    let id: Id
    let created: Date
    let rating: Double
    let writer: Student.Id
    let contents: String
    let images: [URL]
}
