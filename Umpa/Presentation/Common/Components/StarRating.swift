// Created for Umpa in 2025

import SwiftUI

struct StarRating: View {
    let rating: Double

    var ratingString: String {
        String(format: "%.1f", rating)
    }

    init(_ rating: Double) {
        self.rating = rating
    }

    var body: some View {
        HStack(spacing: fs(3)) {
            Image(systemName: "star.fill") // TODO: 실제 리소스로 교체
            Text(ratingString)
                .font(.pretendardSemiBold(size: fs(12)))
                .foregroundStyle(Color.black)
                .lineLimit(1)
        }
    }
}

#Preview {
    StarRating(5.0)
        .padding()
    StarRating(0)
        .padding()
    StarRating(1.8)
        .padding()
    StarRating(2.7)
        .padding()
}
