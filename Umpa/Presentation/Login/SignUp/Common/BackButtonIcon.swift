// Created for Umpa in 2025

import SwiftUI

private struct BackButtonIcon: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color(hex: "#1D1B20"))
                .padding(.horizontal, 12)
        }
    }
}

struct BackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    BackButtonIcon()
                }
            }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BackButtonIcon()
}
