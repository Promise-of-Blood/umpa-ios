// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI

struct FilterSettingViewHeader: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: String

    var body: some View {
        ZStack(alignment: .trailing) {
            Text(title)
                .font(.pretendardBold(size: fs(20)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity)
            Button(action: {
                dismiss()
            }) {
                Image(systemSymbol: .xmark)
                    .font(.system(size: fs(20), weight: .medium))
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    FilterSettingViewHeader(title: "레슨 필터 선택")
}
