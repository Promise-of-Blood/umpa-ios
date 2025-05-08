// Created for Umpa in 2025

import SwiftUI

/// 탭하면 `dismiss`를 호출하는 버튼입니다.
struct DismissButton: View {
    @Environment(\.dismiss) private var dismiss

    let buttonImage: ImageResource

    init(_ buttonImage: ImageResource) {
        self.buttonImage = buttonImage
    }

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(buttonImage)
        }
    }
}

@available(*, deprecated, message: "추후 삭제 예정 : 잘못된 구현")
struct NavigationBackButton: ViewModifier {
    private let buttonImage: ImageResource

    init(_ buttonImage: ImageResource) {
        self.buttonImage = buttonImage
    }

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    DismissButton(buttonImage)
                }
            }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DismissButton(ImageResource(name: "arrow_back", bundle: .main))
}
