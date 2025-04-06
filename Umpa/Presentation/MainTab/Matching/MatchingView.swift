// Created for Umpa in 2025

import Factory
import SwiftUI
import Utility

struct MatchingView: View {
    @Injected(\.serviceInteractor) private var serviceInteractor

    @InjectedObject(\.mainViewSharedData) private var mainViewSharedData

    @State private var serviceList: [any Service] = []

    var body: some View {
        content
            .onAppear {
                Task {
                    try await serviceInteractor.load($serviceList, for: mainViewSharedData.selectedService)
                } catch: { error in
                    // FIXME: Handle error
                    print(error)
                }
            }
    }

    var content: some View {
        VStack(alignment: .leading) {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140)
            HStack(spacing: 8) {
                FilterButton()
                FilterButton()
            }
            Text(mainViewSharedData.selectedService.name)

            ForEach(serviceList, id: \.id) { service in
                ServiceListItem(model: service.toServiceListItemModel())
            }
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
