// Created for Umpa in 2025

import Foundation

public struct Region: Hashable {
    public let regionalLocalGovernment: RegionalLocalGovernment
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
        return "\(regionalLocalGovernment)/\(basicLocalGovernment.name)"
    }
}
