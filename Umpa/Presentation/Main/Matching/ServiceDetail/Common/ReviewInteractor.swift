// Created for Umpa in 2025

import Core
import Domain
import Factory
import Foundation
import SwiftUI

protocol ReviewInteractor {
    func load(_ reviews: Binding<[Review]>, for id: Service.Id)
    func save(_ review: ReviewCreateData)
}

struct ReviewInteractorImpl: ReviewInteractor {
    #if DEBUG
    @Injected(\.stubServerRepository) private var serverRepository
    #else
    @Injected(\.serverRepository) private var serverRepository
    #endif

    private let cancelBag = CancelBag()

    func load(_ reviews: Binding<[Review]>, for id: Service.Id) {
        serverRepository.fetchReviewList()
            .replaceError(with: [])
            .sink(reviews)
            .store(in: cancelBag)
    }

    func save(_ review: ReviewCreateData) {
        serverRepository.postReview(review)
            .replaceError(with: ())
            .sink { _ in }
            .store(in: cancelBag)
    }
}
