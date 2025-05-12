// Created for Umpa in 2025

import Foundation

public struct ScoreCreationService: Service {
  public let id: Id
  public let type: ServiceType
  public let title: String
  public let thumbnail: URL?
  public let rating: Double
  public let author: Teacher
  public let reviews: [Review]
  public let serviceDescription: String
  public let basePrice: Int
  public let majors: [ScoreCreationMajor]
  public let revisionPolicy: RevisionPolicy
  public let turnaround: Turnaround
  public let priceByMajor: [PriceByMajor]
  public let tools: [CompositionTool]
  public let sampleSheets: [SampleSheet]
  public let isLiked: Bool

  public init(
    id: Id,
    type: ServiceType,
    title: String,
    thumbnail: URL?,
    rating: Double,
    author: Teacher,
    reviews: [Review],
    serviceDescription: String,
    basePrice: Int,
    majors: [ScoreCreationMajor],
    revisionPolicy: RevisionPolicy,
    turnaround: Turnaround,
    pricesByMajor: [PriceByMajor],
    tools: [CompositionTool],
    sampleSheets: [SampleSheet],
    isLiked: Bool,
  ) {
    self.id = id
    self.type = type
    self.title = title
    self.thumbnail = thumbnail
    self.rating = rating
    self.author = author
    self.reviews = reviews
    self.serviceDescription = serviceDescription
    self.basePrice = basePrice
    self.majors = majors
    self.revisionPolicy = revisionPolicy
    self.turnaround = turnaround
    self.priceByMajor = pricesByMajor
    self.tools = tools
    self.sampleSheets = sampleSheets
    self.isLiked = isLiked
  }
}

public enum ScoreCreationMajor {
  case vocal
  case piano
  case drum
  case bass
  case guitar
  case fullScore
  case electronicMusic

  public var name: String {
    switch self {
    case .vocal: "보컬"
    case .piano: "피아노"
    case .drum: "드럼"
    case .bass: "베이스"
    case .guitar: "기타"
    case .fullScore: "풀스코어"
    case .electronicMusic: "전자음악"
    }
  }
}

public struct PriceByMajor: Hashable {
  public let price: Int
  public let major: ScoreCreationMajor

  public init(price: Int, major: ScoreCreationMajor) {
    self.price = price
    self.major = major
  }
}

public struct CompositionTool: Hashable {
  public let name: String

  public init(name: String) {
    self.name = name
  }
}

public struct SampleSheet: Hashable {
  public let url: URL?

  public init(url: URL?) {
    self.url = url
  }
}
