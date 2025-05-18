// Created for Umpa in 2025

import Foundation

public struct Rating: Hashable, Comparable {
  public let amount: Float

  public init(amount: Float) {
    self.amount = amount
  }

  public static func < (lhs: Rating, rhs: Rating) -> Bool {
    lhs.amount < rhs.amount
  }
}
