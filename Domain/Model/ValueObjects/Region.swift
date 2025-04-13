// Created for Umpa in 2025

import Foundation

public struct Region: Hashable {
    public let regionalLocalGovernment: String
    public let basicLocalGovernment: String

    public init(regionalLocalGovernment: String, basicLocalGovernment: String) {
        self.regionalLocalGovernment = regionalLocalGovernment
        self.basicLocalGovernment = basicLocalGovernment
    }
}

extension Region {
    public var description: String {
        return "\(regionalLocalGovernment)/\(basicLocalGovernment)"
    }
}
