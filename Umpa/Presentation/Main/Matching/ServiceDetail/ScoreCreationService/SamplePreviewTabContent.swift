// Created for Umpa in 2025

import SwiftUI

extension ScoreCreationServiceDetailView {
    struct SamplePreviewTabContent: View {
        let sampleSheets: [SampleSheet]

        private let sheetImageCornerRadius: CGFloat = fs(10)

        var body: some View {
            VStack(spacing: fs(12)) {
                IndexingForEach(sampleSheets) { _, sampleSheet in
                    AsyncImage(url: sampleSheet.url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray.opacity(0.5)
                    }
                    .frame(maxWidth: .fill, idealHeight: fs(380))
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay {
                        // TODO: 워터 마크 추가
                        Color.blue.opacity(0.1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: sheetImageCornerRadius))
                    .innerRoundedStroke(
                        UmpaColor.lightLightGray,
                        cornerRadius: sheetImageCornerRadius,
                        lineWidth: fs(1)
                    )
                }
            }
            .padding(.horizontal, fs(30))
            .padding(.vertical, fs(22))
        }
    }
}

#Preview {
    ScoreCreationServiceDetailView.SamplePreviewTabContent(
        sampleSheets: ScoreCreationService.sample0.sampleSheets
    )
}
