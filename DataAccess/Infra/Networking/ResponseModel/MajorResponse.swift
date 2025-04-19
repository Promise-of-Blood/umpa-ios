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
    func toDomain() -> Major? {
        switch name {
        case "피아노":
            return .piano
        case "작곡":
            return .composition
        case "드럼":
            return .drum
        case "베이스":
            return .bass
        case "기타":
            return .guitar
        case "보컬":
            return .vocal
        case "전자음악":
            return .electronicMusic
        case "관악":
            return .windInstrument
        default:
            return nil
        }
    }
}
