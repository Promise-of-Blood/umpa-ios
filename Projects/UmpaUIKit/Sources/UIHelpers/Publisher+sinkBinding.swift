// Created for Umpa in 2025

import Combine
import SwiftUI

extension Publisher where Self.Failure == Never {
    public func sink(_ binding: Binding<Output>) -> AnyCancellable {
        sink { output in
            binding.wrappedValue = output
        }
    }
}
