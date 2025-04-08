// Created for Umpa in 2025

import Foundation
import DataAccess

struct Major {
    let name: String
}

extension DataAccess.Major {
    func toDomain() -> Major {
        Major(name: name)
    }
}
