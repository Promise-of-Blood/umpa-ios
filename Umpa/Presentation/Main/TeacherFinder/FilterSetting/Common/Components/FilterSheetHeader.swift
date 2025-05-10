// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI

struct FilterSheetHeader: View {
    let filterEntry: any FilterEntry
    let dismissAction: () -> Void

    var body: some View {
        ZStack(alignment: .trailing) {
            Text(filterEntry.name)
                .font(.pretendardBold(size: fs(20)))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)

            Button(action: dismissAction) {
                Image(systemSymbol: .xmark)
                    .font(.system(size: fs(20), weight: .medium))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, fs(20))
    }
}

#Preview {
    FilterSheetHeader(filterEntry: LessonFilterEntry.college, dismissAction: {})
}
