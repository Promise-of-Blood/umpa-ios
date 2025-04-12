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
        Container.shared.serverRepository.register { StubRepository() }
    }

    @Test func loadChattingRoomList() async throws {
        let chattingRoomList = BindingWithPublisher(
            Loadable<[ChattingRoom], ChattingViewError>.notRequested
        )

        chatInteractor.load(chattingRoomList.binding, for: "")

        let value = await chattingRoomList.updatesRecorder.values.first(where: { _ in true })

        #expect(value?.count == 3)
    }
}
