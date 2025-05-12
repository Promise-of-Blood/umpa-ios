// Created for Umpa in 2025

import AVKit
import Domain
import SwiftUI

struct SampleMusicPreviewTabContent: View {
  let sampleMusicList: [SampleMusic]

  private let videoHeight: CGFloat = fs(172)

  var body: some View {
    content
  }

  var content: some View {
    VStack(spacing: fs(20)) {
      IndexingForEach(sampleMusicList) { _, sampleMusic in
        ZStack {
          if let url = sampleMusic.url {
            VideoPlayer(player: AVPlayer(url: url))
              .frame(maxWidth: .infinity, height: videoHeight)
          } else {
            Text("재생할 수 없습니다.")
              .frame(maxWidth: .infinity, height: videoHeight)
              .background(Color.gray.opacity(0.2))
          }
//          playButton
        }
      }
    }
  }

//  var playButton: some View {
//    Button(action: {
//      // TODO: 플레이 버튼 액션 구현
//    }) {
//      Color.orange
//        .frame(width: fs(22), height: fs(22))
//        .frame(width: fs(42), height: fs(32))
//        .background(
//          .black.opacity(0.5),
//          in: RoundedRectangle(cornerRadius: fs(10))
//        )
//    }
//  }
}
