// Created for Umpa in 2025

import Foundation

public struct ChattingRoomCreateData {
    public let relatedService: any Service

    public init(relatedService: some Service) {
        self.relatedService = relatedService
    }
}
