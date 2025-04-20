// Created for Umpa in 2025

import Domain
import Foundation

public struct CollegeResponse: Decodable {
    public let id: Int
    public let name: String
}

extension CollegeResponse {
    func toDomain() -> College {
        return College(name: name)
    }
}
