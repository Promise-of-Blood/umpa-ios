// Created for Umpa in 2025

import Domain
import Factory
import Foundation
import SwiftUI
import Utility

protocol MentoringInteractor {
    func load(_ mentoringPosts: Binding<[MentoringPost]>)
}

struct DefaultMentoringInteractor: MentoringInteractor {
    @Injected(\.serverRepository) private var serverRepository

    private let cancelBag = CancelBag()

    func load(_ mentoringPosts: Binding<[MentoringPost]>) {
        serverRepository.fetchMentoringPostList()
            .replaceError(with: [])
            .sink(mentoringPosts)
            .store(in: cancelBag)
    }
}
