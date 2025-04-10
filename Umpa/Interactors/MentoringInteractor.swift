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

    func load(_ mentoringPosts: Binding<[MentoringPost]>) {
        let cancelBag = CancelBag()
        serverRepository.fetchMentoringPostList()
            .replaceError(with: [])
            .sink(mentoringPosts)
            .store(in: cancelBag)
    }
}
