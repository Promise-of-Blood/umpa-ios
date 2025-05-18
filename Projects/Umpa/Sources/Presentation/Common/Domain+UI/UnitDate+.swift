// Created for Umpa in 2025

import Domain

extension UnitDate {
  var text: String {
    switch unit {
    case .day:
      "\(amount)일"
    case .week:
      "\(amount)주"
    case .month:
      "\(amount)개월"
    }
  }
}
