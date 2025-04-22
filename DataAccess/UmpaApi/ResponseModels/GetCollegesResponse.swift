// Created for Umpa in 2025

import Domain
import Foundation

typealias GetCollegesResponse = [CollegeDto]

struct CollegeDto: Decodable {
    let id: Int
    let name: String
}

extension CollegeDto {
    func toDomain() -> College {
        return College(name: name)
    }
}
