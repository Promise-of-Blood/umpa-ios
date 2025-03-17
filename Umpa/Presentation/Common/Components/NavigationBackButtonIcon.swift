// Created for Umpa in 2025

import SwiftUI

private struct NavigationBackButtonIcon: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.arrowBack)
                .padding(.horizontal, 12)
        }
    }
}

struct NavigationBackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    NavigationBackButtonIcon()
                }
            }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationBackButtonIcon()
}
