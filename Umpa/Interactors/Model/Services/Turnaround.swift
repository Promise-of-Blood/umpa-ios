// Created for Umpa in 2025

import Foundation

struct Turnaround {
    enum Unit {
        case day
        case week
        case month
    }

    let unit: Unit
    let minDate: Int
    let maxDate: Int
}
