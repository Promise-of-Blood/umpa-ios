// Created for Umpa in 2025

import Domain
import Foundation

typealias GetMajorsResponse = [MajorDto]

struct MajorDto: Decodable {
    let id: Int
    let name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

extension MajorDto {
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
