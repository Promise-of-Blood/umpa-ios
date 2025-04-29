// Created for Umpa in 2025

import Foundation

typealias GetRegionsResponse = [RegionalLocalGovernmentDto]

struct RegionalLocalGovernmentDto: Decodable {
    let id: Int
    let name: String
    let items: [BasicLocalGovernmentDto]
}

struct BasicLocalGovernmentDto: Decodable {
    let id: Int
    let name: String
}
