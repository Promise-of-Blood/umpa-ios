// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultChatRepository {
    private let network: Network

    public init(network: Network) {
        self.network = network
    }
}

extension DefaultChatRepository: ChatRepository {
    public func fetchChatRoomList() -> AnyPublisher<[Domain.ChatRoom], any Error> {
        fatalError()
    }

    public func fetchChatRoom(for id: Domain.AnyService.Id) -> AnyPublisher<Domain.ChatRoom?, any Error> {
        fatalError()
    }

    public func fetchChatRoom(by id: Domain.ChatRoom.Id) -> AnyPublisher<Domain.ChatRoom, any Error> {
        let request = GetChatRoomRequest(id: id)
        network.requestPublisher(request)
        fatalError()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubChatRepository {
    public init() {}
}

extension StubChatRepository: ChatRepository {
    public func fetchChatRoomList() -> AnyPublisher<[Domain.ChatRoom], any Error> {
        Just([ChatRoom.sample0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postChatMessage(_ message: Domain.ChatMessage) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchChatRoom(by id: Domain.ChatRoom.Id) -> AnyPublisher<Domain.ChatRoom, any Error> {
        Just(ChatRoom.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchChatRoom(for id: String) -> AnyPublisher<Domain.ChatRoom?, any Error> {
        let chatRoomList = [ChatRoom.sample0]
        let matchedChatRoom = chatRoomList.first { chatRoom in
            chatRoom.relatedService.id == id
        }

        return Just(matchedChatRoom)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif
