// Created for Umpa in 2025

import SwiftUI
import UmpaUIKit

struct SplashView: View {
  var body: some View {
    Image(.umpaLogo)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: fs(140))
  }
}

#Preview {
  SplashView()
}
