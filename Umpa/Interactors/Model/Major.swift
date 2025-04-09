// Created for Umpa in 2025

import Foundation
import DataAccess

struct Major: Hashable {
    let name: String
}

extension DataAccess.Major {
    func toDomain() -> Major {
        Major(name: name)
    }
}
