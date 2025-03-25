// Created for Umpa in 2025

import Foundation

public struct RegionalLocalGovernment: Decodable {
    public let id: Int
    public let name: String
    public let items: [BasicLocalGovernment]
}

public struct BasicLocalGovernment: Decodable {
    public let id: Int
    public let name: String
}
