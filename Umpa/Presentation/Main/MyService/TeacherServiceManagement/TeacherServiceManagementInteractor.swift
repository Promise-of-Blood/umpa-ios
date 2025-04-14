// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol TeacherServiceManagementInteractor {
    func loadMyServiceList(_ serviceList: Binding<[any Service]>)
    func enterChatRoom(for id: Service.Id)
//    func sendServiceConfirmationRequest
}

struct DefaultTeacherServiceManagementInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository

    private let cancelBag = CancelBag()
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

    func loadMyServiceList(_ serviceList: Binding<[any Domain.Service]>) {
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyServiceList(with:))
            .replaceError(with: [])
            .sink(serviceList)
            .store(in: cancelBag)
    }
}

enum TeacherServiceManagementInteractorError: Error {
    case noChatRoomForServiceId
}
