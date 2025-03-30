// Created for Umpa in 2025

import Foundation

struct AccompanistService: SinglePriceService {
    let id: String?
    let type: ServiceType
    let title: String
    let thumbnail: URL?
    let rating: Double
    let author: Teacher
    let acceptanceReviews: [AcceptanceReview]
    let reviews: [Review]
    let serviceDescription: String
    let price: Int
    let chargeDescription: String?
    let instruments: [Major]
    let ensemblePolicy: EnsemblePolicy
    let isServingMusicRecorded: Bool
    let ensemblePlace: EnsemblePlace
}

struct EnsemblePolicy {
    let freeCount: Int
    let price: Int
}

struct EnsemblePlace: OptionSet {
    let rawValue: UInt8

    static let privateStudio = EnsemblePlace(rawValue: 1 << 0)
    static let rentalStudio = EnsemblePlace(rawValue: 1 << 1)
    static let studentPreference = EnsemblePlace(rawValue: 1 << 2)

    static let all: EnsemblePlace = [.privateStudio, .rentalStudio, .studentPreference]
}

#if MOCK
extension AccompanistService {
    static let sample0 = AccompanistService(
        id: "accompanistService0",
        type: .accompanist,
        title: "반주자도 중요합니다",
        thumbnail: nil,
        rating: 3.5,
        author: .sample0,
        acceptanceReviews: [],
        reviews: [],
        serviceDescription:
        """
        2022 년부터 입시 반주를 진행했습니다.
        많은 학생들과 입시장에 함께 들어갔고, 합격시킨 학생 정말 많습니다. 반주자의 중요성을 모르는 사람이 많은 것 같지만, 좋은 반주자와 함께 해야 좋은 연주가 나온답니다~!
        """,
        price: 160_000,
        chargeDescription: nil,
        instruments: [
            Major(name: "피아노"),
        ],
        ensemblePolicy: EnsemblePolicy(freeCount: 2, price: 20_000),
        isServingMusicRecorded: true,
        ensemblePlace: [.privateStudio, .studentPreference]
    )
}
#endif
