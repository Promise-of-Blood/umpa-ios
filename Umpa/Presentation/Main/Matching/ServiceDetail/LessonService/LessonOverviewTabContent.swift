// Created for Umpa in 2025

import SwiftUI

extension LessonServiceDetailView {
    struct LessonOverviewTabContent: View {
        let service: LessonService

        var body: some View {
            Text("LessonOverviewTabContent")
        }

        //        var scheduleCard: some View {
        //            switch service.scheduleType {
        //            case .byStudent:
        //
        //            case .fixed:
        //            }
        //
        //            HStack {
        //                Image("icSchedule")
        //                VStack {
        //                    Text("수업 일정")
        //                }
        //            }
        //        }
    }
}

#Preview {
    LessonServiceDetailView.LessonOverviewTabContent(service: .sample0)
}
