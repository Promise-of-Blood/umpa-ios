// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol ReviewInteractor {
    @MainActor
    func load(_ reviews: Binding<[Review]>, for id: ServiceId) async throws
}

struct DefaultReviewInteractor: ReviewInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ reviews: Binding<[Review]>, for id: ServiceId) async throws {
        fatalError()
    }
}

enum ReviewInteractorError: Error {
    case invalidId
}

#if DEBUG
struct MockReviewInteractor: ReviewInteractor {
    func load(_ reviews: Binding<[Review]>, for id: ServiceId) async throws {
        if id.isEmpty {
            throw ReviewInteractorError.invalidId
        }

        reviews.wrappedValue = [
            Review.sample0,
            Review.sample1,
        ]
    }
}
#endif
