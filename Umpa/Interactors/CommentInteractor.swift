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

    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.ID) {
        let cancelBag = CancelBag()
        serverRepository.fetchAcceptanceReviewCommentList(by: id)
            .replaceError(with: [])
            .sink(comments)
            .store(in: cancelBag)
    }

    func post(_ comment: AcceptanceReview.Comment) {
        fatalError()
    }
}
