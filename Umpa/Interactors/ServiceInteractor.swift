// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol ServiceInteractor {
    @MainActor
    func load(_ lessonServices: Binding<[LessonService]>) async throws
}

struct DefaultServiceInteractor: ServiceInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ lessonServices: Binding<[LessonService]>) async throws {
        fatalError()
    }
}

#if DEBUG
struct MockServiceInteractor: ServiceInteractor {
    func load(_ lessonServices: Binding<[LessonService]>) async throws {
        lessonServices.wrappedValue = [
            LessonService.sample0,
        ]
    }
}
#endif
