// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import Foundation
import SwiftUI

protocol ReviewInteractor {
    @MainActor
    func load(_ reviews: Binding<[Review]>, for id: Service.Id) async throws

    @MainActor
    func save(_ review: Review) async throws
}

struct DefaultReviewInteractor: ReviewInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ reviews: Binding<[Review]>, for id: Service.Id) async throws {
        fatalError()
    }

    func save(_ review: Review) async throws {
        fatalError()
    }
}

enum ReviewInteractorError: Error {
    case invalidId
}

#if MOCK
struct MockReviewInteractor: ReviewInteractor {
    func load(_ reviews: Binding<[Review]>, for id: Service.Id) async throws {
        if id.isEmpty {
            throw ReviewInteractorError.invalidId
        }

        reviews.wrappedValue = [
            Review.sample0,
            Review.sample1,
        ]
    }

    func save(_ review: Review) async throws {}
}
#endif
