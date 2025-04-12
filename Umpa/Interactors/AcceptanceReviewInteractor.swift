// Created for Umpa in 2025

import Combine
import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol AcceptanceReviewInteractor {
    /// 모든 합격 후기를 불러옵니다.
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>)

    /// `id`에 해당하는 합격 후기를 불러옵니다.
    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id)

    /// Hot 합격 후기 목록을 불러옵니다.
    func loadHotAcceptanceReviews(_ acceptanceReviews: Binding<[AcceptanceReview]>)

    /// 합격 후기를 작성합니다.
    func post(_ acceptanceReview: AcceptanceReview)
}

struct DefaultAcceptanceReviewInteractor: AcceptanceReviewInteractor {
    @Injected(\.serverRepository) private var serverRepository

    let cancelBag = CancelBag()

    func loadHotAcceptanceReviews(_ acceptanceReviews: Binding<[AcceptanceReview]>) {
        serverRepository.fetchHotAcceptanceReviewList()
            .replaceError(with: [])
            .sink(acceptanceReviews)
            .store(in: cancelBag)
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>) {
        serverRepository.fetchAllAcceptanceReviewList()
            .replaceError(with: [])
            .sink(acceptanceReviews)
            .store(in: cancelBag)
    }

    func load(_ acceptanceReviews: Binding<[AcceptanceReview]>, for id: Service.Id) {
        serverRepository.fetchAcceptanceReviewList(by: id)
            .replaceError(with: [])
            .sink(acceptanceReviews)
            .store(in: cancelBag)
    }

    func post(_ acceptanceReview: AcceptanceReview) {
        fatalError()
    }
}
