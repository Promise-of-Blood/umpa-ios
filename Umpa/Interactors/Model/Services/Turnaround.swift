// Created for Umpa in 2025

import Foundation

struct Turnaround: Hashable {
    let minDate: UnitDate
    let maxDate: UnitDate
}

struct UnitDate: Hashable {
    enum Unit {
        case day
        case week
        case month
    }

    let amount: Int
    let unit: Unit
}
