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

    func load(_ reviews: Binding<[Review]>, for id: Service.Id) {
        let cancelBag = CancelBag()
        serverRepository.fetchReviewList()
            .replaceError(with: [])
            .sink(reviews)
            .store(in: cancelBag)
    }

    func save(_ review: Review) {
        fatalError()
    }
}
