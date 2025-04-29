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
    func toDomain() -> Major {
        return Major(name: name)
    }
}
