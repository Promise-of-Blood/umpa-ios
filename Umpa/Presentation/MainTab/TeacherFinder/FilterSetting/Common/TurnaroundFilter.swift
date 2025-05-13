// Created for Umpa in 2025

import Foundation

enum TurnaroundFilter: Hashable, CaseIterable {
    case all
    case lessThanOrEqual1Month
    case lessThanOrEqual3Weeks
    case lessThanOrEqual2Weeks
    case lessThanOrEqual1Week
    case lessThanOrEqual5Days
    case lessThanOrEqual3Days
    case sameDay
}
