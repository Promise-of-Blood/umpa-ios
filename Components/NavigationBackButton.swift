// Created for Umpa in 2025

import SwiftUI

private struct NavigationBackButtonIcon: View {
    @Environment(\.dismiss) private var dismiss

    private let buttonImage: ImageResource

    init(_ buttonImage: ImageResource) {
        self.buttonImage = buttonImage
    }

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(buttonImage)
                .padding(.horizontal, 12)
        }
    }
}

public struct NavigationBackButton: ViewModifier {
    private let buttonImage: ImageResource

    public init(_ buttonImage: ImageResource) {
        self.buttonImage = buttonImage
    }

    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    NavigationBackButtonIcon(buttonImage)
                }
            }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationBackButtonIcon(ImageResource(name: "arrow_back", bundle: .main))
}
