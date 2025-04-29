// Created for Umpa in 2025

import Combine
import Core
import Domain
import Mockable
import Testing
@testable import Umpa

@Suite(.tags(.interactor))
final class ChatInteractorTests {
    var sut: ChatInteractor!
    var mockChatRepository: MockChatRepository!

    init() {
        mockChatRepository = MockChatRepository()
        sut = DefaultChatInteractor(
            appState: AppState(),
            chatRepository: mockChatRepository
        )
    }
}

extension ChatInteractorTests {
    @Test func loadChatRoomList() async throws {
        // Given
        let mockData = [ChatRoom.sample0]
        let mockDataPublisher = Just(mockData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let chatRoomList = BindingWithPublisher(
            Loadable<[ChatRoom], ChatInteractorError>.notRequested
        )

        given(mockChatRepository)
            .fetchChatRoomList().willReturn(mockDataPublisher)

        // When
        await sut.load(chatRoomList.binding)

        // Then
        let recorded = await chatRoomList.updatesRecorder.values.first(where: { _ in true })
        #expect(recorded == [
            .notRequested,
            .isLoading(last: nil, cancelBag: CancelBag()),
            .loaded(mockData)
        ])
        verify(mockChatRepository)
            .fetchChatRoomList().called(.once)
    }
}
