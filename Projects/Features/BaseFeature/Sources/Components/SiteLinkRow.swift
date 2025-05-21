// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI
import UmpaUIKit

public struct SiteLinkRow: View {
  @Bindable var link: SiteLinkModel

  let discardAction: () -> Void

  @State private var isShowingDeleteConfirm = false

  public init(link: Bindable<SiteLinkModel>, discardAction: @escaping () -> Void) {
    _link = link
    self.discardAction = discardAction
  }

  public var body: some View {
    HStack(spacing: fs(10)) {
      link.icon

      TextField("사이트 링크", text: $link.link, prompt: Text("사이트 링크"))
        .font(.pretendardMedium(size: fs(15)))
        .foregroundStyle(UmpaColor.darkGray)
        .textInputAutocapitalization(.never)

      Button(action: { isShowingDeleteConfirm = true }) {
        Image(systemSymbol: .trash)
          .foregroundStyle(.red)
          .font(.system(size: 16, weight: .medium))
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, fs(20))
    .padding(.vertical, fs(18))
    .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: fs(15))
    .confirmationDialog("이 링크를 삭제하시겠습니까?", isPresented: $isShowingDeleteConfirm) {
      Button("삭제", role: .destructive, action: discardAction)
      Button("취소", role: .cancel) {}
    }
  }
}
