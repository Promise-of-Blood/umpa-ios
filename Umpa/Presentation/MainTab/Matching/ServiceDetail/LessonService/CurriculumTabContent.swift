// Created for Umpa in 2025

import Components
import SwiftUI

extension LessonServiceDetailView {
    struct CurriculumTabContent: View {
        let curriculumList: [CurriculumItem]

        private let cornerRadius: CGFloat = fs(10)

        var body: some View {
            VStack(alignment: .leading, spacing: fs(0)) {
                IndexingForEach(curriculumList) { index, curriculum in
                    VStack(alignment: .leading, spacing: fs(10)) {
                        Text(curriculum.title)
                            .font(.pretendardMedium(size: fs(12)))
                            .foregroundStyle(UmpaColor.mediumGray)
                        Text(curriculum.description)
                            .font(.pretendardRegular(size: fs(14)))
                            .foregroundStyle(UmpaColor.darkGray)
                    }
                    .padding(.horizontal, fs(14))
                    .padding(.vertical, fs(18))

                    if index < curriculumList.count - 1 {
                        HorizontalDivider(thickness: fs(1), color: UmpaColor.lightGray)
                    }
                }
            }
            .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: cornerRadius, lineWidth: fs(1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(.horizontal, fs(30))
            .padding(.vertical, fs(22))
            .background(.white)
        }
    }
}

#Preview {
    ScrollView {
        LessonServiceDetailView.CurriculumTabContent(curriculumList: LessonService.sample0.curriculum)
    }
    .padding()
    .background(.black)
}
