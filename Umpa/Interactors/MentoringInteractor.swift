// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import Foundation
import SwiftUI

protocol MentoringInteractor {
    @MainActor
    func load(_ mentoringPosts: Binding<[MentoringPost]>) async throws
}

struct DefaultMentoringInteractor: MentoringInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ mentoringPosts: Binding<[MentoringPost]>) async throws {
        fatalError()
    }
}

#if MOCK
struct MockMentoringInteractor: MentoringInteractor {
    func load(_ mentoringPosts: Binding<[MentoringPost]>) async throws {
        mentoringPosts.wrappedValue = [
            MentoringPost.sample0,
        ]
    }
}
#endif
