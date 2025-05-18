// Created for Umpa in 2025

import SwiftUI

extension View {
    public nonisolated func onChanges<each V>(
        of values: repeat each V,
        initial: Bool = false,
        action: @escaping () -> Void
    ) -> some View where repeat each V: Equatable {
        var view = AnyView(self)

        for value in repeat each values {
            view = AnyView(view.onChange(of: value, initial: initial, action))
        }

        return view
    }
}
