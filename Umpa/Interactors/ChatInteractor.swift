// Created for Umpa in 2025

import Factory
import Foundation
import DataAccess
import SwiftUI

protocol ChatInteractor {
    @MainActor
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws

    @MainActor
    func createChattingRoom(for service: any Service) async throws
}

struct DefaultChatInteractor: ChatInteractor {
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws {
        fatalError()
    }

    func createChattingRoom(for service: any Service) async throws {
        let serviceId = service.id
        let teacherId = service.author.id
        fatalError()
    }
}

#if MOCK
struct MockChatInteractor: ChatInteractor {
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws {
        chats.wrappedValue = [
            .sample0,
        ]
    }

    func createChattingRoom(for service: any Service) async throws {}
}
#endif
