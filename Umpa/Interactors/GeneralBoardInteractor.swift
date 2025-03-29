// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol GeneralBoardInteractor {
    @MainActor
    func load(_ boards: Binding<[Post]>, filter: Post.Filter) async throws

    @MainActor
    func load(_ hotPosts: Binding<[Post]>) async throws

    @MainActor
    func post(_ post: Post) async throws
}
