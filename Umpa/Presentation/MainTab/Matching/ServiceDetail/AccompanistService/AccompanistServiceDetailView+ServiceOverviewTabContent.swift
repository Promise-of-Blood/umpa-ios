// Created for Umpa in 2025

import Domain
import SwiftUI

extension AccompanistServiceDetailView {
    struct ServiceOverviewTabContent: View {
        let service: AccompanistService

        var body: some View {
            Text("반주 정보")
        }
    }
}

#Preview {
    AccompanistServiceDetailView.ServiceOverviewTabContent(service: .sample0)
}
