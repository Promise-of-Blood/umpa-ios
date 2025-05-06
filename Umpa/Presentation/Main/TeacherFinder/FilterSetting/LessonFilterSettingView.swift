// Created for Umpa in 2025

import Components
import Domain
import SFSafeSymbols
import SwiftUI

struct LessonFilterSettingView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: 0) {
            VStack(spacing: fs(40)) {
                header
                filterList
            }
            .padding(.horizontal, fs(20))

            Spacer()

            FilterSettingBottomActionView(
                applyButtonTitle: "필터 설정 완료",
                resetButtonTitle: "전체 초기화",
                applyAction: {},
                resetAction: {}
            )
        }
    }

    var header: some View {
        ZStack(alignment: .trailing) {
            Text("필터 설정")
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

    var filterList: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(
                    Array(zip(LessonFilterEntry.allCases.indices, LessonFilterEntry.allCases)),
                    id: \.1.id
                ) { index, filter in
                    Button(action: {}) {
                        HStack {
                            Text(filter.name)
                                .font(.pretendardBold(size: fs(18)))
                                .foregroundStyle(.black)

                            Spacer()

                            HStack(spacing: fs(5)) {
                                Text("전체")
                                    .font(.pretendardMedium(size: fs(16)))
                                Image(systemSymbol: .chevronRight)
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .foregroundStyle(UmpaColor.mainBlue)
                        }
                        .padding(.vertical, fs(24))
                    }

                    if index < LessonFilterEntry.allCases.count - 1 {
                        HorizontalDivider(color: UmpaColor.baseColor)
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: .vertical)
    }
}

#Preview {
    LessonFilterSettingView()
}
