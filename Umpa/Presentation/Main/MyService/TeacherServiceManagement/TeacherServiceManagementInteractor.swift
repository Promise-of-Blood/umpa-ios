// Created for Umpa in 2025

import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

@MainActor
protocol TeacherServiceManagementInteractor {
    func loadMyServiceList(_ serviceList: Binding<[AnyService]>)
    func enterChatRoom(for id: Service.Id)
//    func sendServiceConfirmationRequest
}

struct DefaultTeacherServiceManagementInteractor {
    private var appState: AppState

    private var serverRepository: ServerRepository

    private var getAccessToken: GetAccessTokenUseCase

    private let cancelBag = CancelBag()

    init(
        appState: AppState,
        serverRepository: ServerRepository,
        getAccessTokenUseCase: GetAccessTokenUseCase
    ) {
        self.appState = appState
        self.serverRepository = serverRepository
        self.getAccessToken = getAccessTokenUseCase
    }
}

extension DefaultTeacherServiceManagementInteractor: TeacherServiceManagementInteractor {
    func enterChatRoom(for id: Service.Id) {
        serverRepository.fetchChatRoom(for: id)
            .tryMap { chatRoom in
                guard let chatRoom else {
                    throw TeacherServiceManagementInteractorError.noChatRoomForServiceId
                }
                return chatRoom
            }
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { chatRoom in
                appState.routing.myServicesNavigationPath.append(chatRoom)
            }
            .store(in: cancelBag)
    }

    func loadMyServiceList(_ serviceList: Binding<[AnyService]>) {
        getAccessToken()
            .tryMap { accessToken in
                guard let accessToken else { throw UmpaError.missingAccessToken }
                return accessToken
            }
            .flatMap(serverRepository.fetchMyServiceList(with:))
            .replaceError(with: [])
            .sink(serviceList)
            .store(in: cancelBag)
    }
}

enum TeacherServiceManagementInteractorError: LocalizedError {
    case noChatRoomForServiceId

    var errorDescription: String? {
        switch self {
        case .noChatRoomForServiceId:
            return "해당 서비스에 대한 채팅방을 찾을 수 없습니다."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .noChatRoomForServiceId:
            return "서비스 제공자에게 문의하거나 다시 시도해보세요."
        }
    }
}
