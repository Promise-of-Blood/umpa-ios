// Created for Umpa in 2025

import Domain
import SwiftUI

extension MrCreationServiceDetailView {
    struct ServiceOverviewTabContent: View {
        let service: MusicCreationService

        var body: some View {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    #if MOCK
    MrCreationServiceDetailView.ServiceOverviewTabContent(service: .sample0)
    #endif
}
