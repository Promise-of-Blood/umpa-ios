// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol TeacherServiceManagementInteractor {
    func loadMyServiceList(_ serviceList: Binding<[AnyService]>)
    func enterChatRoom(for id: Service.Id)
//    func sendServiceConfirmationRequest
}

struct TeacherServiceManagementInteractorImpl {
    @Injected(\.appState) private var appState
    @Injected(\.stubServerRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository

    private let cancelBag = CancelBag()
}

extension TeacherServiceManagementInteractorImpl: TeacherServiceManagementInteractor {
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
        keychainRepository.getAccessToken()
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
