// Created for Umpa in 2025

import SwiftUI

struct SignUpMajorSelectionView: View {
    @State private var selectedMajor = Major.piano

    var body: some View {
        VStack {
            Text("전공을 선택해주세요")
                .modifier(TitleText())
            Spacer()
            Picker("Major", selection: $selectedMajor) {
                Text("피아노").tag(Major.piano)
                Text("드럼").tag(Major.drum)
                Text("기타").tag(Major.guitar)
                Text("바이올린").tag(Major.violin)
                Text("첼로").tag(Major.cello)
            }
            Spacer()
            NavigationLink {
                SignUpFinishView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(BackButton())
    }
}

#Preview {
    NavigationStack {
        SignUpMajorSelectionView()
    }
}

enum Major {
    case piano
    case drum
    case guitar
    case violin
    case cello
}
