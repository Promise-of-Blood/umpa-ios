// Created for Umpa in 2025

import Factory
import SwiftUI

struct MatchingView: View {
    @InjectedObject(\.mainViewModel) private var mainViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140)
            HStack(spacing: 8) {
                FilterButton()
                FilterButton()
            }
            Text(mainViewModel.selectedSubject ?? "")
//            PricePerTime(price: 100_000)
        }
    }
}

struct FilterButton: View {
    private let cornerRadius: CGFloat = 20
    private let foregroundColor = UmpaColor.lightGray

    var body: some View {
        HStack(spacing: 8) {
            Text("Filter")
                .foregroundStyle(foregroundColor)
            icon
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 9)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color(hex: "EBEBEB"), lineWidth: 1)
        }
        .onTapGesture {
            fatalError()
        }
    }

    var icon: some View {
        let squareSide: CGFloat = 12
        return Rectangle()
            .foregroundStyle(foregroundColor)
            .frame(width: squareSide, height: squareSide)
    }
}

struct ListItem: View {
    var body: some View {
        fatalError()
    }
}

#Preview {
    MatchingView()
}
