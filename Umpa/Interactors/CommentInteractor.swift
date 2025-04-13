// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol CommentInteractor {
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.ID)
    func post(_ comment: AcceptanceReview.Comment)
}

struct DefaultCommentInteractor: CommentInteractor {
    @Injected(\.serverRepository) private var serverRepository

    let cancelBag = CancelBag()

    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.ID) {
        serverRepository.fetchAcceptanceReviewCommentList(by: id)
            .replaceError(with: [])
            .sink(comments)
            .store(in: cancelBag)
    }

    func post(_ comment: AcceptanceReview.Comment) {
        fatalError()
    }
}
