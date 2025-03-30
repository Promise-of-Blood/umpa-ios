// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol AcceptanceReviewInteractor {
    @MainActor
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws

    @MainActor
    func save(_ acceptanceReview: AcceptanceReview) async throws
}

struct DefaultAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws {
        fatalError()
    }

    func save(_ acceptanceReview: AcceptanceReview) async throws {
        fatalError()
    }
}

#if DEBUG
struct MockAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws {
        acceptanceReviews.wrappedValue = [
            AcceptanceReview.sample0,
        ]
    }

    func save(_ acceptanceReview: AcceptanceReview) async throws {}
}
#endif
