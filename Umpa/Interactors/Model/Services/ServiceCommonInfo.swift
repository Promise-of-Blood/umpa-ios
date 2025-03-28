// Created for Umpa in 2025

import Foundation

typealias ServiceId = String

struct ServiceCommonInfo: Identifiable {
    let id: ServiceId?
    let title: String
    let thumbnail: URL?
    let rating: Double
    let author: Teacher.Id
    let acceptanceReviews: [AcceptanceReview]
    let reviews: [Review]
}
