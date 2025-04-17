// Created for Umpa in 2025

import AVKit
import Domain
import SwiftUI

extension MrCreationServiceDetailView {
    struct SamplePreviewTabContent: View {
        let sampleMusics: [SampleMusic]

        var body: some View {
            content
                .padding(fs(30))
        }

        var content: some View {
            VStack(spacing: fs(20)) {
                IndexingForEach(sampleMusics) { _, sampleMusic in
                    ZStack {
                        if let url = sampleMusic.url {
                            VideoPlayer(player: AVPlayer(url: url))
                                .frame(maxWidth: .fill, idealHeight: fs(172))
                                .fixedSize(horizontal: false, vertical: true)
                        } else {
                            Text("재생할 수 없습니다.")
                                .frame(maxWidth: .fill, idealHeight: fs(172))
                                .background(Color.gray.opacity(0.2))
                        }
//                        playButton
                    }
                }
            }
        }

        var playButton: some View {
            Button(action: {
                // TODO: 플레이 버튼 액션 구현
            }) {
                Color.orange
                    .frame(width: fs(22), height: fs(22))
                    .frame(width: fs(42), height: fs(32))
                    .background(
                        .black.opacity(0.5),
                        in: RoundedRectangle(cornerRadius: fs(10))
                    )
            }
        }
    }
}

#Preview {
    #if DEBUG
    MrCreationServiceDetailView.SamplePreviewTabContent(
        sampleMusics: MusicCreationService.sample0.sampleMusics
    )
    #endif
}
