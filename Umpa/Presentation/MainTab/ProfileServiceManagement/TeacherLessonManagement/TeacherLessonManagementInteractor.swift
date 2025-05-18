// Created for Umpa in 2025

import BaseFeature
import Combine
import Core
import Domain
import Factory
import Foundation
import SwiftUI

@MainActor
protocol TeacherLessonManagementInteractor {
  func loadMyLessonList(_ lessonList: Binding<[LessonService]>)
  func enterChatRoom(for id: Service.Id)
  func closeLesson(by id: LessonService.Id)
//    func sendLessonConfirmationRequest
  func executeCommissionPayment(for id: LessonService.Id)
}

struct DefaultTeacherLessonManagementInteractor {
  private let appState: AppState

  private let serviceRepository: ServiceRepository
  private let chatRepository: ChatRepository

  private let getAccessToken: GetAccessTokenUseCase

  private let cancelBag = CancelBag()

  init(
    appState: AppState,
    serviceRepository: ServiceRepository,
    chatRepository: ChatRepository,
    getAccessTokenUseCase: GetAccessTokenUseCase
  ) {
    self.appState = appState
    self.serviceRepository = serviceRepository
    self.chatRepository = chatRepository
    getAccessToken = getAccessTokenUseCase
  }
}

extension DefaultTeacherLessonManagementInteractor: TeacherLessonManagementInteractor {
  func executeCommissionPayment(for id: Domain.LessonService.Id) {
    fatalError()
  }

  func closeLesson(by id: Domain.LessonService.Id) {
    fatalError()
  }

  func enterChatRoom(for id: Service.Id) {
    chatRepository.fetchChatRoom(for: id)
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
    getAccessToken()
      .tryMap { accessToken in
        guard let accessToken else { throw UmpaError.missingAccessToken }
        return accessToken
      }
      .flatMap(serviceRepository.fetchMyLessonList(with:))
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
      "해당 레슨에 대한 채팅방을 찾을 수 없습니다."
    }
  }

  var recoverySuggestion: String? {
    switch self {
    case .noChatRoomForLessonId:
      "레슨 제공자에게 문의하거나 다시 시도해보세요."
    }
  }
}
