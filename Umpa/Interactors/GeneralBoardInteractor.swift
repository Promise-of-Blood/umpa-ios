// Created for Umpa in 2025

import Factory
import Foundation
import DataAccess
import SwiftUI

protocol GeneralBoardInteractor {
    @MainActor
    func load(_ boards: Binding<[Post]>, filter: Post.Filter) async throws

    @MainActor
    func loadHotPosts(_ hotPosts: Binding<[Post]>) async throws

    @MainActor
    func post(_ post: Post) async throws
}

struct DefaultGeneralBoardInteractor: GeneralBoardInteractor {
    @Injected(\.umpaApi) private var umpaApi

    func load(_ boards: Binding<[Post]>, filter: Post.Filter) async throws {
        fatalError()
    }

    func loadHotPosts(_ hotPosts: Binding<[Post]>) async throws {
        fatalError()
    }

    func post(_ post: Post) async throws {
        fatalError()
    }
}

#if MOCK
struct MockGeneralBoardInteractor: GeneralBoardInteractor {
    func load(_ boards: Binding<[Post]>, filter: Post.Filter) async throws {
        let posts: [Post]
        switch filter {
        case .all:
            posts = [
                .sample0,
            ]
        case .onlyQuestions:
            posts = [
                .sample1,
            ]
        case .excludeQuestions:
            posts = [
                .sample0,
            ]
        }
        boards.wrappedValue = posts
    }

    func loadHotPosts(_ hotPosts: Binding<[Post]>) async throws {
        hotPosts.wrappedValue = [
            .sample0,
            .sample1,
        ]
    }

    func post(_ post: Post) async throws {}
}
#endif
