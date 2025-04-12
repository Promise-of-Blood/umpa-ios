// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol ReviewInteractor {
    func load(_ reviews: Binding<[Review]>, for id: Service.Id)
    func save(_ review: Review)
}

struct DefaultReviewInteractor: ReviewInteractor {
    @Injected(\.serverRepository) private var serverRepository

    let cancelBag = CancelBag()

    func load(_ reviews: Binding<[Review]>, for id: Service.Id) {
        serverRepository.fetchReviewList()
            .replaceError(with: [])
            .sink(reviews)
            .store(in: cancelBag)
    }

    func save(_ review: Review) {
        fatalError()
    }
}
