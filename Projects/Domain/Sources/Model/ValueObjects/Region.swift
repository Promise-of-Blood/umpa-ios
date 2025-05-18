// Created for Umpa in 2025

import Foundation

public struct Region: Hashable {
  /// 특별시, 광역시, 도
  public let regionalLocalGovernment: RegionalLocalGovernment

  /// 시, 군, 구
  public let basicLocalGovernment: BasicLocalGovernment

  public init(
    regionalLocalGovernment: RegionalLocalGovernment,
    basicLocalGovernment: BasicLocalGovernment
  ) {
    self.regionalLocalGovernment = regionalLocalGovernment
    self.basicLocalGovernment = basicLocalGovernment
  }
}

extension Region {
  public var description: String {
    "\(regionalLocalGovernment)/\(basicLocalGovernment.name)"
  }
}
