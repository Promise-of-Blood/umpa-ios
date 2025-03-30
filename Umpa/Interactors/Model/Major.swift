// Created for Umpa in 2025

import Foundation
import Networking

struct Major {
    let name: String
}

extension Networking.Major {
    func toDomain() -> Major {
        Major(name: name)
    }
}
