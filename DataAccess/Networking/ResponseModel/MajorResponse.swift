// Created for Umpa in 2025

import Domain
import Foundation

public struct MajorResponse: Decodable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension MajorResponse {
    func toDomain() -> Major {
        Major(name: name)
    }
}
