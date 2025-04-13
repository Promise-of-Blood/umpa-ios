// Created for Umpa in 2025

import Foundation

public struct MusicCreationService: SinglePriceService {
    public let id: String?
    public let type: ServiceType
    public let title: String
    public let thumbnail: URL?
    public let rating: Double
    public let author: Teacher
    public let acceptanceReviews: [AcceptanceReview]
    public let reviews: [Review]
    public let serviceDescription: String
    public let price: Int
    public let chargeDescription: String
    public let tools: [MusicCreationTool]
    public let turnaround: Turnaround
    public let revisionPolicy: RevisionPolicy
    public let sampleMusics: [SampleMusic]

    public init(
        id: String?,
        type: ServiceType,
        title: String,
        thumbnail: URL?,
        rating: Double,
        author: Teacher,
        acceptanceReviews: [AcceptanceReview],
        reviews: [Review],
        serviceDescription: String,
        price: Int,
        chargeDescription: String,
        tools: [MusicCreationTool],
        turnaround: Turnaround,
        revisionPolicy: RevisionPolicy,
        sampleMusics: [SampleMusic]
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.thumbnail = thumbnail
        self.rating = rating
        self.author = author
        self.acceptanceReviews = acceptanceReviews
        self.reviews = reviews
        self.serviceDescription = serviceDescription
        self.price = price
        self.chargeDescription = chargeDescription
        self.tools = tools
        self.turnaround = turnaround
        self.revisionPolicy = revisionPolicy
        self.sampleMusics = sampleMusics
    }
}

public struct MusicCreationTool: Hashable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

public struct SampleMusic: Hashable {
    public let url: URL?

    public init(url: URL?) {
        self.url = url
    }
}
