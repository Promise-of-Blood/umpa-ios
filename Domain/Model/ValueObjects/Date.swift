// Created for Umpa in 2025

import Foundation

public struct YMDate: Hashable {
    public let year: Int
    public let month: Int

    public init?(year: Int, month: Int) {
        guard Validator(year: year, month: month).validate() else {
            return nil
        }
        self.year = year
        self.month = month
    }

    public init(date: Date) {
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
    }

    public static var now: YMDate {
        YMDate(date: .now)
    }
}

extension YMDate: Comparable {
    public static func < (lhs: YMDate, rhs: YMDate) -> Bool {
        lhs.year < rhs.year || (lhs.year == rhs.year && lhs.month < rhs.month)
    }
}

extension YMDate {
    struct Validator: Domain.Validator {
        let year: Int
        let month: Int

        func validate() -> Bool {
            guard month >= 1 && month <= 12 else {
                return false
            }
            guard year >= 1900 && year <= 2100 else {
                return false
            }
            return true
        }
    }
}
