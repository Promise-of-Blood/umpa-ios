// Created for Umpa in 2025

import Foundation

/// 전공
public struct Major: Hashable, Decodable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
