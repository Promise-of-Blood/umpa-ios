// Created for Umpa in 2025

import Foundation

public protocol Service: Identifiable, Hashable {
  typealias Id = String

  var id: Id { get }
  var type: ServiceType { get }
  var title: String { get }
  var thumbnail: URL? { get }
  
  /// 전체 평균 평점
  var rating: Double { get }
  var author: Teacher { get }
  var reviews: [Review] { get }
  var serviceDescription: String { get }
  var isLiked: Bool { get }
}

public protocol SinglePriceService: Service {
  var price: Int { get }
}
