// Created for Umpa in 2025

import Foundation
import DataAccess

struct College: Hashable {
    let name: String
}

extension DataAccess.College {
    func toDomain() -> College {
        return College(name: name)
    }
}
