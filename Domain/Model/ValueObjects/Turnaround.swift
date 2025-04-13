// Created for Umpa in 2025

import Foundation

/// 소요 기간
public struct Turnaround: Hashable {
    public let minDate: UnitDate
    public let maxDate: UnitDate

    public init(minDate: UnitDate, maxDate: UnitDate) {
        self.minDate = minDate
        self.maxDate = maxDate
    }
}

public struct UnitDate: Hashable {
    public enum Unit {
        case day
        case week
        case month
    }

    public let amount: Int
    public let unit: Unit

    public init(amount: Int, unit: Unit) {
        self.amount = amount
        self.unit = unit
    }
}
