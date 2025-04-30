// Created for Umpa in 2025

import Foundation

public struct Experience: Hashable {
    public let title: String
    public let startDate: YMDate
    public let endDate: YMDate
    public let isRepresentative: Bool

    init?(title: String, startDate: YMDate, endDate: YMDate, isRepresentative: Bool) {
        guard Validator(title: title, startDate: startDate, endDate: endDate).validate() else {
            return nil
        }

        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isRepresentative = isRepresentative
    }
}

extension Experience {
    struct Validator: Domain.Validator {
        let title: String
        let startDate: YMDate
        let endDate: YMDate

        func validate() -> Bool {
            let limitTitleLength = 100
            guard title.count <= limitTitleLength else { return false }

            guard startDate <= endDate else { return false }

            return true
        }
    }
}
