// Created for Umpa in 2025

import Combine
import Domain
import Mockable
import Testing
@testable import Umpa
import Core

@Suite(.tags(.interactor))
final class ChatInteractorTests {
    var sut: ChatInteractor!
    var mockServerRepository: MockServerRepository!

    init() {
        mockServerRepository = MockServerRepository()
        sut = ChatInteractorImpl(
            appState: AppState(),
            serverRepository: mockServerRepository
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

        given(mockServerRepository)
            .fetchChatRoomList().willReturn(mockDataPublisher)

        // When
        sut.load(chatRoomList.binding)

        // Then
        let recorded = await chatRoomList.updatesRecorder.values.first(where: { _ in true })
        #expect(recorded == [
            .notRequested,
            .isLoading(last: nil, cancelBag: CancelBag()),
            .loaded(mockData)
        ])
        verify(mockServerRepository)
            .fetchChatRoomList().called(.once)
    }
}
