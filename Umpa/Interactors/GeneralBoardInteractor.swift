// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol GeneralBoardInteractor {
    func load(_ boards: Binding<[Post]>, filter: Post.Filter)
    func loadHotPosts(_ hotPosts: Binding<[Post]>)
    func post(_ post: Post)
}

struct DefaultGeneralBoardInteractor: GeneralBoardInteractor {
    @Injected(\.serverRepository) private var serverRepository

    func load(_ boards: Binding<[Post]>, filter: Post.Filter) {
        let cancelBag = CancelBag()
        serverRepository.fetchPostList(with: filter)
            .replaceError(with: [])
            .sink(boards)
            .store(in: cancelBag)
    }

    func loadHotPosts(_ hotPosts: Binding<[Post]>) {
        let cancelBag = CancelBag()
        serverRepository.fetchHotPostList()
            .replaceError(with: [])
            .sink(hotPosts)
            .store(in: cancelBag)
    }

    func post(_ post: Post) {
        fatalError()
    }
}
