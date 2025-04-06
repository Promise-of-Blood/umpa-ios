// Created for Umpa in 2025

import Foundation

struct ScoreCreationService: Service {
    let id: String?
    let type: ServiceType
    let title: String
    let thumbnail: URL?
    let rating: Double
    let author: Teacher
    let acceptanceReviews: [AcceptanceReview]
    let reviews: [Review]
    let serviceDescription: String
    let basePrice: Int
    let majors: [ScoreCreationMajor]
    let revisionPolicy: RevisionPolicy
    let turnaround: Turnaround
    let pricesByMajor: [PriceByMajor]
    let tools: [CompositionTool]
    let sampleSheets: [SampleSheet]
}

enum ScoreCreationMajor {
    case vocal
    case piano
    case drum
    case bass
    case guitar
    case fullScore
    case electronicMusic

    var name: String {
        switch self {
        case .vocal: return "보컬"
        case .piano: return "피아노"
        case .drum: return "드럼"
        case .bass: return "베이스"
        case .guitar: return "기타"
        case .fullScore: return "풀스코어"
        case .electronicMusic: return "전자음악"
        }
    }
}

struct PriceByMajor {
    let price: Int
    let major: ScoreCreationMajor
}

struct CompositionTool {
    let name: String
}

struct SampleSheet {
    let url: URL?
}

#if MOCK
extension ScoreCreationService {
    static let sample0 = ScoreCreationService(
        id: "compositionService0",
        type: .scoreCreation,
        title: "입시 악보 제작 합니다",
        thumbnail: nil,
        rating: 4.5,
        author: .sample0,
        acceptanceReviews: [],
        reviews: [],
        serviceDescription:
        """
        입시 악보 제작 합니다

        악보 제작 경력 몇년입니다
        믿고 맡겨주세요
        업게 최고 빠른 작업 속도!
        짱 저렴한 가격~!
        """,
        basePrice: 20_000,
        majors: [
            .vocal,
            .piano,
            .drum,
            .bass,
        ],
        revisionPolicy: RevisionPolicy(freeCount: 2, price: 5_000),
        turnaround: Turnaround(unit: .day, minDate: 3, maxDate: 7),
        pricesByMajor: [
            PriceByMajor(price: 20_000, major: .vocal),
            PriceByMajor(price: 40_000, major: .piano),
            PriceByMajor(price: 20_000, major: .drum),
            PriceByMajor(price: 30_000, major: .bass),
        ],
        tools: [
            CompositionTool(name: "시벨리우스"),
        ],
        sampleSheets: [
            SampleSheet(url: URL(string: "https://www.musicscore.co.kr/sample/samp7ys7f3ij9wkjid8eujfhsiud843dsijfowejfisojf3490fi0if0sjk09jkr039uf90u/8u4ojsjdjf430foeid409ijef923jerojfgojdofj894jjdsf934f90f40ufj390rfjds/sample_102000/sample_Y3Zp6CqGi2024040332204.jpg")),
        ]
    )
}
#endif
