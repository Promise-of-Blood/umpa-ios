// Created for Umpa in 2025

import SwiftUI

/// 탭하면 `dismiss`를 호출하는 버튼입니다.
public struct DismissButton: View {
  @Environment(\.dismiss) private var dismiss

  let buttonImage: ImageResource

  public init(_ buttonImage: ImageResource) {
    self.buttonImage = buttonImage
  }

  public var body: some View {
    Button {
      dismiss()
    } label: {
      Image(buttonImage)
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  DismissButton(ImageResource(name: "arrow_back", bundle: .main))
}
