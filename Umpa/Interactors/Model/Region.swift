// Created for Umpa in 2025

import Foundation

struct Region: Hashable {
    let regionalLocalGovernment: String
    let basicLocalGovernment: String
}

extension Region {
    var description: String {
        return "\(regionalLocalGovernment)/\(basicLocalGovernment)"
    }
}
