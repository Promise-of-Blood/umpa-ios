// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI
import Utility

struct MatchingView: View {
    @InjectedObject(\.appState) private var appState

    @Injected(\.serviceInteractor) private var serviceInteractor

    @State private var serviceList: [any Service] = []

    var body: some View {
        NavigationStack {
            content
        }
        .onAppear {
            serviceInteractor.load(
                $serviceList,
                for: appState.userData.teacherFinding.selectedService
            )
        }
    }

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
            Text(appState.userData.teacherFinding.selectedService.name)
            ForEach(serviceList, id: \.id) { service in
                switch service {
                case let lessonService as LessonService:
                    NavigationLink {
                        LessonServiceDetailView(service: lessonService)
                    } label: {
                        ServiceListItem(model: service.toServiceListItemModel())
                    }
                case let accompanistService as AccompanistService:
                    NavigationLink {
                        AccompanistServiceDetailView(service: accompanistService)
                    } label: {
                        ServiceListItem(model: service.toServiceListItemModel())
                    }
                case let musicCreationService as MusicCreationService:
                    NavigationLink {
                        MrCreationServiceDetailView(service: musicCreationService)
                    } label: {
                        ServiceListItem(model: service.toServiceListItemModel())
                    }
                case let scoreCreationService as ScoreCreationService:
                    NavigationLink {
                        ScoreCreationServiceDetailView(service: scoreCreationService)
                    } label: {
                        ServiceListItem(model: service.toServiceListItemModel())
                    }
                default:
                    preconditionFailure("\(type(of: service)) 타입이 처리되지 않았습니다.")
                }
            }
        }
        .frame(maxHeight: .fill, alignment: .top)
    }
}

extension MatchingView {
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
    MatchingView()
}
