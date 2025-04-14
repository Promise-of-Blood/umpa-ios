// Created for Umpa in 2025

import Foundation

public struct UmpaNotification: Identifiable, Hashable {
    public let id: String
    public let title: String

    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
