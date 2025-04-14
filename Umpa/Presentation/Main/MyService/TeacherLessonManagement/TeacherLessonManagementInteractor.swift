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
}

struct DefaultTeacherLessonManagementInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.serverRepository) private var serverRepository
    @Injected(\.keychainRepository) private var keychainRepository

    private let cancelBag = CancelBag()
}

extension DefaultTeacherLessonManagementInteractor: TeacherLessonManagementInteractor {
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

enum TeacherLessonManagementInteractorError: Error {
    case noChatRoomForLessonId
}
