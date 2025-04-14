// Created for Umpa in 2025

import Combine
import DataAccess
import Domain
import Factory
import Testing
@testable import Umpa
import Utility

@Suite(.tags(.interactor))
struct ChatInteractorTests {
    @Injected(\.chatInteractor) private var chatInteractor

    init() {
        Container.shared.reset()
        Container.shared.serverRepository.register { StubServerRepository() }
    }

    @Test func loadChattingRoomList() async throws {
        let chatRoomList = BindingWithPublisher(
            Loadable<[ChatRoom], ChatInteractorError>.notRequested
        )

        chatInteractor.load(chatRoomList.binding, for: "")

        let value = await chatRoomList.updatesRecorder.values.first(where: { _ in true })

        #expect(value?.count == 3)
    }
}
