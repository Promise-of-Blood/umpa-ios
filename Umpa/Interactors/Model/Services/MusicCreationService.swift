// Created for Umpa in 2025

import Foundation

struct MusicCreationService: SinglePriceService {
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
    let chargeDescription: String
    let tools: [MusicCreationTool]
    let turnaround: Turnaround
    let revisionPolicy: RevisionPolicy
    let sampleMusics: [SampleMusic]
}

struct MusicCreationTool {
    let name: String
}

struct SampleMusic {
    let url: URL?
}

#if MOCK
extension MusicCreationService {
    static let sample0 = MusicCreationService(
        id: "musicCreationService0",
        type: .mrCreation,
        title: "엠알 제작 내가 최고",
        thumbnail: nil,
        rating: 4.0,
        author: .sample0,
        acceptanceReviews: [],
        reviews: [],
        serviceDescription:
        """
        MR 제작합니다.

        최고 퀄리티 보장합니다.
        """,
        price: 100_000,
        chargeDescription: "기본 2 트랙 (피아노 + 드럼) 기준. 트랙 추가시 각 트랙 별 20,000원 추가",
        tools: [
            MusicCreationTool(name: "에이블톤"),
        ],
        turnaround: Turnaround(unit: .week, minDate: 1, maxDate: 2),
        revisionPolicy: RevisionPolicy(freeCount: 1, price: 10_000),

        sampleMusics: [
            SampleMusic(url: URL(string: "https://youtu.be/r6TwzSGYycM?si=BK53S-MP6U1HCaWP")),
        ]
    )
}
#endif
