// Created for Umpa in 2025

import BaseFeature
import Core
import Domain
import SwiftUI
import UmpaUIKit

public struct SiteLinkSettingSheet: SettingSheet {
  @Binding var isPresenting: Bool
  @Binding var truthLinks: [String]

  @State private var editableLinks: Editable<[SiteLinkModel]> = .confirmed([])
  @FocusState private var focusedID: UUID?

  public init(isPresenting: Binding<Bool>, truthLinks: Binding<[String]>) {
    _isPresenting = isPresenting
    _truthLinks = truthLinks
  }

  // MARK: View

  public var body: some View {
    InstinctHeightSheet(
      isPresenting: $isPresenting,
      dismissAction: { editableLinks.cancel() }
    ) {
      content
    }
    .onChange(of: truthLinks, initial: true) { _, newValue in
      let newLinks = newValue
        .filter(\.isNotEmpty)
        .map { SiteLinkModel(link: $0) }
      editableLinks.confirm(newLinks)
    }
  }

  @ViewBuilder
  private var content: some View {
    VStack(spacing: fs(16)) {
      title("사이트 링크")
      VStack(spacing: fs(8)) {
        ForEach(editableLinks.current) { link in
          SiteLinkRow(link: Bindable(link), discardAction: { didTapDeleteButton(of: link) })
            .focused($focusedID, equals: link.id)
        }
        if editableLinks.current.count < Teacher.SiteLinkValidator.maxCount {
          AddLinkRow(action: didTapAddButton)
        }
      }
      .padding(.horizontal, fs(20))

      Spacer()

      acceptButton {
        truthLinks = editableLinks.current
          .map(\.link)
          .filter(\.isNotEmpty)
        isPresenting = false
      }
    }
  }

  // MARK: Private Methods

  private func didTapDeleteButton(of link: SiteLinkModel) {
    withAnimation {
      let newValue = editableLinks.current.filter { $0.id != link.id }
      editableLinks.setEditing(newValue)
    }
  }

  private func didTapAddButton() {
    withAnimation {
      let newLink = SiteLinkModel(link: "")
      editableLinks.setEditing(editableLinks.current + [newLink])
      DispatchQueue.main.async { focusedID = newLink.id }
    }
  }
}

private struct AddLinkRow: View {
  let action: () -> Void
  private let height: CGFloat = fs(44)

  var body: some View {
    Button(action: action) {
      Image(systemSymbol: .plus)
        .font(.system(size: 30, weight: .heavy))
        .foregroundStyle(UmpaColor.lightBlue)
        .frame(maxWidth: .infinity, height: height)
        .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(10))
    }
  }
}

#Preview {
  @Previewable @State var isPresenting = false
  @Previewable @State var linkStrings = [
    "https://instagram.com/user",
  ]

  ZStack {
    VStack(spacing: 30) {
      Button("Present") {
        isPresenting = true
      }
    }
    Spacer()
    SiteLinkSettingSheet(isPresenting: $isPresenting, truthLinks: $linkStrings)
  }
}
