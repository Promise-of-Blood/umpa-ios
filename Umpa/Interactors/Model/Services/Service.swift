// Created for Umpa in 2025

import Foundation

protocol Service: Identifiable {
    typealias Id = String

    var id: Id? { get }
    var type: ServiceType { get }
    var title: String { get }
    var thumbnail: URL? { get }
    var rating: Double { get }
    var author: Teacher { get }
    var acceptanceReviews: [AcceptanceReview] { get }
    var reviews: [Review] { get }
    var serviceDescription: String { get }
}

protocol SinglePriceService: Service {
    var price: Int { get }
}
