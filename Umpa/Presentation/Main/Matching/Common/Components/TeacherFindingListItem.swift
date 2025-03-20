// Created for Umpa in 2025

import SwiftUI

struct TeacherFindingListItem: View {
    struct Model {
        let title: String
        let lessonInfo: LessonInfo.Model
        let description: String
        let pricePerUnit: PricePerUnit.Model
        let image: ImageResource
    }

    let model: Model

    var body: some View {
        HStack(spacing: fs(10)) {
            VStack(alignment: .leading, spacing: fs(8)) {
                Text(model.title)
                    .font(.pretendardBold(size: fs(16)))
                    .foregroundStyle(UmpaColor.charcoal)
                    .frame(maxWidth: .fill, alignment: .leading)
                    .lineLimit(1)
                LessonInfo(model: model.lessonInfo)
                Text(model.description)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.lightGray)
                    .frame(maxWidth: .fill, alignment: .leading)
                    .lineLimit(1)
                PricePerUnit(
                    model: model.pricePerUnit,
                    attributes: PricePerUnit.Attributes(priceColor: UmpaColor.darkBlue)
                )
            }
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: fs(70), height: fs(70))
                .background(Color(hex: "D9D9D9"))
                .clipShape(Circle())
        }
        .frame(maxWidth: .fill)
        .padding(.horizontal, fs(2))
        .padding(.vertical, fs(16))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TeacherFindingListItem(model: TeacherFindingListItem.Model.example1)
        .frame(width: 280)
        .border(Color.black)
        .padding()
        .border(Color.black)
    TeacherFindingListItem(model: TeacherFindingListItem.Model.example2)
        .frame(width: 320)
        .border(Color.black)
        .padding()
        .border(Color.black)
}

#if DEBUG
extension TeacherFindingListItem.Model {
    static let example1 = TeacherFindingListItem.Model(
        title: "가고 싶은 학교 무조건 가는 방법",
        lessonInfo: LessonInfo.Model.example1,
        description: "서울예대 작곡 전공 교수님들의 귀염둥이이자 어쩌구",
        pricePerUnit: PricePerUnit.Model.example1,
        image: ImageResource(name: "", bundle: .main)
    )

    static let example2 = TeacherFindingListItem.Model(
        title: "초견 때문에 입시가 두려우신 분 들어 오던지 말던지",
        lessonInfo: LessonInfo.Model.example2,
        description: "야옹야옹야옹야옹야옹미야옹야옹야옹야옹야오양옹",
        pricePerUnit: PricePerUnit.Model.example3,
        image: .sample
    )
}
#endif
