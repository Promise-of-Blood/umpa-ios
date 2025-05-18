// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol ChatRepository {
    func fetchChatRoomList() -> AnyPublisher<[ChatRoom], Error>
    func fetchChatRoom(for id: AnyService.Id) -> AnyPublisher<ChatRoom?, Error>
    func fetchChatRoom(by id: ChatRoom.Id) -> AnyPublisher<ChatRoom, Error>

    func postChatMessage(_ message: ChatMessage) -> AnyPublisher<Void, Error>
}
