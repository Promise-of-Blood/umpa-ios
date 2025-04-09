// Created for Umpa in 2025

import DataAccess
import Domain
import Factory
import Foundation
import SwiftUI

protocol CommentInteractor {
    @MainActor
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws

    @MainActor
    func post(_ comment: AcceptanceReview.Comment) async throws
}

struct DefaultCommentInteractor: CommentInteractor {
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws {
        fatalError()
    }

    func post(_ comment: AcceptanceReview.Comment) async throws {
        fatalError()
    }
}

#if MOCK
struct MockCommentInteractor: CommentInteractor {
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws {
        comments.wrappedValue = [
            .sample0,
            .sample1,
        ]
    }

    func post(_ comment: AcceptanceReview.Comment) async throws {}
}
#endif
