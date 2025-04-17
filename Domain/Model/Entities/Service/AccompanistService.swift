// Created for Umpa in 2025

import Foundation

public struct AccompanistService: SinglePriceService {
    public let id: Id
    public let type: ServiceType
    public let title: String
    public let thumbnail: URL?
    public let rating: Double
    public let author: Teacher
    public let acceptanceReviews: [AcceptanceReview]
    public let reviews: [Review]
    public let serviceDescription: String
    public let price: Int
    public let chargeDescription: String?
    public let instruments: [Major]
    public let ensemblePolicy: EnsemblePolicy
    public let isServingMusicRecorded: Bool
    public let ensemblePlace: EnsemblePlace

    public init(
        id: Id,
        type: ServiceType,
        title: String,
        thumbnail: URL?,
        rating: Double,
        author: Teacher,
        acceptanceReviews: [AcceptanceReview],
        reviews: [Review],
        serviceDescription: String,
        price: Int,
        chargeDescription: String?,
        instruments: [Major],
        ensemblePolicy: EnsemblePolicy,
        isServingMusicRecorded: Bool,
        ensemblePlace: EnsemblePlace
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
        self.instruments = instruments
        self.ensemblePolicy = ensemblePolicy
        self.isServingMusicRecorded = isServingMusicRecorded
        self.ensemblePlace = ensemblePlace
    }
}

extension AccompanistService {
    /// 합주 정책
    public struct EnsemblePolicy: Hashable {
        public let freeCount: Int
        public let price: Int

        public init(freeCount: Int, price: Int) {
            self.freeCount = freeCount
            self.price = price
        }
    }

    /// 합주 장소
    public struct EnsemblePlace: OptionSet, Hashable {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        public static let privateStudio = EnsemblePlace(rawValue: 1 << 0)
        public static let rentalStudio = EnsemblePlace(rawValue: 1 << 1)
        public static let studentPreference = EnsemblePlace(rawValue: 1 << 2)

        public static let all: EnsemblePlace = [.privateStudio, .rentalStudio, .studentPreference]
    }
}
