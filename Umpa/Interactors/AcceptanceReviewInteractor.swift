// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol AcceptanceReviewInteractor {
    @MainActor
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: ServiceId) async throws
}

struct DefaultAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: ServiceId) async throws {
        fatalError()
    }
}

#if DEBUG
struct MockAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: ServiceId) async throws {
        acceptanceReviews.wrappedValue = [
            AcceptanceReview(
                id: "acceptanceReview0",
                comments: [
                    AcceptanceReview.Comment(contents: "와 정말 축하해요~~~~!!!!", writer: "user0"),
                    AcceptanceReview.Comment(contents: "나도 합격하고 싶다...", writer: "user1"),
                ]
            ),
        ]
    }
}
#endif
