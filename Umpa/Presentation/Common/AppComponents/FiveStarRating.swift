// Created for Umpa in 2025

import SwiftUI

struct FiveStarRating: View {
  let rating: Binding<CGFloat>
  let maxRating: Int = 5

  let appearance: Appearance

  init(rating: Binding<CGFloat>, appearance: Appearance = .fromDefault()) {
    self.rating = rating
    self.appearance = appearance
  }

  var body: some View {
    let stars = HStack(spacing: appearance.spacing) {
      ForEach(0 ..< maxRating, id: \.self) { _ in
        Image(systemName: "star.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
    }

    stars.overlay {
      GeometryReader { proxy in
        let roundedRating = calculateRoundedRating(rating.wrappedValue)
        let width = roundedRating / CGFloat(maxRating) * proxy.size.width
        Rectangle()
          .frame(width: width)
          .foregroundColor(appearance.foregroundColor)
      }
      .mask(stars)
    }
    .foregroundColor(appearance.backgroundColor)
  }

  private func calculateRoundedRating(_ rating: CGFloat) -> CGFloat {
    // 2.3 -> 4.6 -> 5 -> 2.5
    // 2.2 -> 4.4 -> 4 -> 2
    let roundedRating = round(rating * 2) / 2
    return min(max(roundedRating, 0), CGFloat(maxRating))
  }
}

extension FiveStarRating {
  struct Appearance {
    let foregroundColor: Color
    let backgroundColor: Color
    let spacing: CGFloat

    static func appearance(
      foregroundColor: Color,
      backgroundColor: Color,
      spacing: CGFloat
    ) -> Appearance {
      Appearance(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        spacing: spacing
      )
    }

    static func fromDefault(
      foregroundColor: Color = .yellow,
      backgroundColor: Color = .gray,
      spacing: CGFloat = 0,
    ) -> Appearance {
      Appearance(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        spacing: spacing
      )
    }
  }
}

#Preview {
  FiveStarRating(rating: .constant(3.4))
    .padding()
  FiveStarRating(rating: .constant(0))
    .padding()
  FiveStarRating(rating: .constant(6))
    .padding()

  FiveStarRating(
    rating: .constant(2.3),
    appearance: .appearance(
      foregroundColor: .blue,
      backgroundColor: UmpaColor.lightGray,
      spacing: 12
    )
  )
  .frame(width: 200)
  .padding()
}
