// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol CommentInteractor {
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.ID)
    func post(_ comment: AcceptanceReviewCommentCreateData)
}

struct DefaultCommentInteractor: CommentInteractor {
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()

    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.ID) {
        serverRepository.fetchAcceptanceReviewCommentList(by: id)
            .replaceError(with: [])
            .sink(comments)
            .store(in: cancelBag)
    }

    func post(_ comment: AcceptanceReviewCommentCreateData) {
        serverRepository.postAcceptanceReviewComment(comment)
            .sink { completion in
                if let error = completion.error {
                    // TODO: Handle error
                }
            } receiveValue: { _ in }
            .store(in: cancelBag)
    }
}
