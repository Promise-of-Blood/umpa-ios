// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol AcceptanceReviewInteractor {
    /// 모든 합격 후기를 불러옵니다.
    @MainActor
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws

    /// `id`에 해당하는 합격 후기를 불러옵니다.
    @MainActor
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws

    /// Hot 합격 후기 목록을 불러옵니다.
    @MainActor
    func loadHotAcceptanceReviews(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws

    /// 합격 후기를 작성합니다.
    @MainActor
    func post(_ acceptanceReview: AcceptanceReview) async throws
}

struct DefaultAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func loadHotAcceptanceReviews(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws {
        fatalError()
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws {
        fatalError()
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws {
        fatalError()
    }

    func post(_ acceptanceReview: AcceptanceReview) async throws {
        fatalError()
    }
}

#if MOCK
struct MockAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    func loadHotAcceptanceReviews(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws {
        acceptanceReviews.wrappedValue = [
            AcceptanceReview.sample0,
        ]
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>) async throws {
        acceptanceReviews.wrappedValue = [
            AcceptanceReview.sample0,
        ]
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) async throws {
        acceptanceReviews.wrappedValue = [
            AcceptanceReview.sample0,
        ]
    }

    func post(_ acceptanceReview: AcceptanceReview) async throws {}
}
#endif
