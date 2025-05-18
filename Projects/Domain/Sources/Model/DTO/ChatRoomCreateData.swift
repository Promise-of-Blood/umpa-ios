// Created for Umpa in 2025

import Foundation

public struct ChatRoomCreateData {
    public let relatedService: AnyService

    public init(relatedService: AnyService) {
        self.relatedService = relatedService
    }
}
