// Created for Umpa in 2025

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension PreviewTrait where T == Preview.ViewTraits {
  @MainActor public static var iPhoneSE: PreviewTrait<Preview.ViewTraits> {
    .fixedLayout(width: 375, height: 667)
  }
}
