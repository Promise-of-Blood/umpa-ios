// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol CommentInteractor {
    @MainActor
    func load(_ comments: Binding<[Question.Comment]>, for id: Question.Id) async throws

    @MainActor
    func post(_ comment: Question.Comment) async throws

    @MainActor
    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws

    @MainActor
    func post(_ comment: AcceptanceReview.Comment) async throws
}

struct DefaultCommentInteractor: CommentInteractor {
    func load(_ comments: Binding<[Question.Comment]>, for id: Question.Id) async throws {
        fatalError()
    }

    func post(_ comment: Question.Comment) async throws {
        fatalError()
    }

    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws {
        fatalError()
    }

    func post(_ comment: AcceptanceReview.Comment) async throws {
        fatalError()
    }
}

#if DEBUG
struct MockCommentInteractor: CommentInteractor {
    func load(_ comments: Binding<[Question.Comment]>, for id: Question.Id) async throws {
        comments.wrappedValue = [
            .sample0,
            .sample1,
            .sample2,
        ]
    }

    func post(_ comment: Question.Comment) async throws {}

    func load(_ comments: Binding<[AcceptanceReview.Comment]>, for id: AcceptanceReview.Id) async throws {
        comments.wrappedValue = [
            .sample0,
            .sample1,
        ]
    }

    func post(_ comment: AcceptanceReview.Comment) async throws {}
}
#endif
