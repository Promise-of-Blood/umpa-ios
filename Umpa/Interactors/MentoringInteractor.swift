// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol MentoringInteractor {
    @MainActor
    func load(_ mentoringPosts: Binding<[MentoringPost]>) async throws
}
