// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol ChatInteractor {
    @MainActor
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws

    @MainActor
    func create(_ chat: ChattingRoom) async throws
}

struct DefaultChatInteractor: ChatInteractor {
    func load(_ chats: Binding<[ChattingRoom]>, for id: User.Id) async throws {
        fatalError()
    }

    func create(_ chat: ChattingRoom) async throws {
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

    func create(_ chat: ChattingRoom) async throws {}
}
#endif
