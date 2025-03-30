// Created for Umpa in 2025

import Foundation
import Networking

struct College {
    let name: String
}

extension Networking.College {
    func toDomain() -> College {
        return College(name: name)
    }
}
