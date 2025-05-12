// Created for Umpa in 2025

import SwiftUI

protocol ServiceOverviewTab: View {}

extension ServiceOverviewTab {
  func makeContentCard(@ViewBuilder _ content: () -> some View) -> some View {
    let horiozontalPadding: CGFloat = fs(20)
    let verticalPadding: CGFloat = fs(24)
    let cardCornerRadius: CGFloat = fs(10)

    return content()
      .frame(maxWidth: .infinity)
      .padding(.horizontal, horiozontalPadding)
      .padding(.vertical, verticalPadding)
      .background(.white)
      .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: cardCornerRadius)
  }
}
