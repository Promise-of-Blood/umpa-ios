// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol TeacherLessonManagementInteractor {
    func loadMyLessonList(_ lessonList: Binding<[LessonService]>)
    func enterChatRoom(for id: Service.Id)
    func closeLesson(by id: LessonService.Id)
//    func sendLessonConfirmationRequest
    func executeCommissionPayment(for id: LessonService.Id)
}

struct TeacherLessonManagementInteractorImpl {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository

    private let cancelBag = CancelBag()
}

extension TeacherLessonManagementInteractorImpl: TeacherLessonManagementInteractor {
    func executeCommissionPayment(for id: Domain.LessonService.Id) {
        fatalError()
    }

    func closeLesson(by id: Domain.LessonService.Id) {
        fatalError()
    }

    func enterChatRoom(for id: Service.Id) {
        serverRepository.fetchChatRoom(for: id)
            .tryMap { chatRoom in
                guard let chatRoom else {
                    throw TeacherLessonManagementInteractorError.noChatRoomForLessonId
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

    func loadMyLessonList(_ lessonList: Binding<[Domain.LessonService]>) {
        keychainRepository.getAccessToken()
            .flatMap(serverRepository.fetchMyLessonList(with:))
            .replaceError(with: [])
            .sink(lessonList)
            .store(in: cancelBag)
    }
}

enum TeacherLessonManagementInteractorError: LocalizedError {
    case noChatRoomForLessonId

    var errorDescription: String? {
        switch self {
        case .noChatRoomForLessonId:
            return "해당 레슨에 대한 채팅방을 찾을 수 없습니다."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .noChatRoomForLessonId:
            return "레슨 제공자에게 문의하거나 다시 시도해보세요."
        }
    }
}
