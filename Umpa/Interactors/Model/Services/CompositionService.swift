// Created for Umpa in 2025

import Foundation

struct CompositionService {
    let baseInfo: ServiceCommonInfo
    let basePrice: Int
    let majors: [CompositionMajor]
    let revisionPolicy: RevisionPolicy
    let turnaround: Turnaround
    let pricesByMajor: [PriceByMajor]
    let tools: [CompositionTool]
    let serviceDescription: String
    let sampleSheets: [URL?]
}

enum CompositionMajor {
    case vocal
    case piano
    case drum
    case bass
    case guitar
    case fullScore
    case electronicMusic
}

struct PriceByMajor {
    let price: Int
    let major: CompositionMajor
}

struct CompositionTool {
    let name: String
}

#if DEBUG
extension CompositionService {
    static let sample0 = CompositionService(
        baseInfo: ServiceCommonInfo(
            id: "compositionService0",
            title: "입시 악보 제작 합니다",
            thumbnail: nil,
            rating: 4.5,
            author: "teacher0",
            acceptanceReviews: [],
            reviews: []
        ),
        basePrice: 20_000,
        majors: [
            .vocal,
            .piano,
            .drum,
            .bass,
        ],
        revisionPolicy: RevisionPolicy(freeCount: 2, price: 5_000),
        turnaround: Turnaround(minDate: 3, maxDate: 7),
        pricesByMajor: [
            PriceByMajor(price: 20_000, major: .vocal),
            PriceByMajor(price: 40_000, major: .piano),
            PriceByMajor(price: 20_000, major: .drum),
            PriceByMajor(price: 30_000, major: .bass),
        ],
        tools: [
            CompositionTool(name: "시벨리우스"),
        ],
        serviceDescription:
        """
        입시 악보 제작 합니다

        악보 제작 경력 몇년입니다
        믿고 맡겨주세요
        업게 최고 빠른 작업 속도!
        짱 저렴한 가격~!
        """,
        sampleSheets: []
    )
}
#endif
