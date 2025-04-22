// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct ServiceListView: View {
    @Injected(\.appState) private var appState

    #if DEBUG
    @Injected(\.stubServiceListInteractor) private var serviceListInteractor
    #else
    @Injected(\.serviceListInteractor) private var serviceListInteractor
    #endif

    @State private var serviceList: [AnyService] = []

    var body: some View {
        content
            .onAppear {
                serviceListInteractor.load(
                    $serviceList,
                    for: appState.userData.teacherFinder.selectedService
                )
            }
            .navigationDestination(for: AnyService.self) { service in
                if let lesson = service.unwrap(as: LessonService.self) {
                    LessonServiceDetailView(service: lesson)
                }
                else if let accompanistService = service.unwrap(as: AccompanistService.self) {
                    AccompanistServiceDetailView(service: accompanistService)
                }
                else if let musicCreationService = service.unwrap(as: MusicCreationService.self) {
                    MrCreationServiceDetailView(service: musicCreationService)
                }
                else if let scoreCreationService = service.unwrap(as: ScoreCreationService.self) {
                    ScoreCreationServiceDetailView(service: scoreCreationService)
                }
            }
    }

    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading) {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: fs(42))
            HStack(spacing: 8) {
                FilterButton()
                FilterButton()
            }
            Text(appState.userData.teacherFinder.selectedService.name)
            ForEach(serviceList, id: \.id) { service in
                NavigationLink(value: service) {
                    ServiceListItem(model: service.toServiceListItemModel())
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

extension ServiceListView {
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
}

#Preview {
    ServiceListView()
}
