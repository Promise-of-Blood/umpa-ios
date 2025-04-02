// Created for Umpa in 2025

import Components
import SwiftUI

struct TeacherOverviewTabContent: View {
    let teacher: Teacher

    var body: some View {
        VStack {
            Text(teacher.keyphrase)
                .font(.pretendardSemiBold(size: fs(15)))
                .frame(maxWidth: .fill, alignment: .leading)
                .padding()
            VStack(spacing: fs(30)) {
                HStack {
                    AsyncImage(url: teacher.profileImage) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: fs(50), height: fs(50))
                    .clipShape(Circle())
                    VStack {
                        Text(teacher.name)
//                        teacher.links
                    }
                }
                .frame(maxWidth: .fill, alignment: .leading)
                experiences
                Text(teacher.introduction)
            }
            .padding()
            .innerStroke(Color(hex: "EBEBEB"), cornerRadius: fs(10), lineWidth: fs(1))
        }
    }

    var experiences: some View {
        VStack(alignment: .leading, spacing: fs(6)) {
            ForEach(teacher.experiences, id: \.self) { experience in
                HStack {
                    Circle()
                        .frame(width: fs(14), height: fs(14))
                        .foregroundStyle(UmpaColor.mainBlue)
                    Text(experience)
                }
            }
        }
        .frame(maxWidth: .fill, alignment: .leading)
    }
}

#Preview {
    @Previewable @State var tabSelection = 1

    let tabItems = ["1", "2", "3"]

    VStack {
        BottomLineSegmentedControl(
            tabItems,
            selection: $tabSelection,
            buttonWidth: fs(70)
        )
        .padding(.horizontal, 30)

        switch tabSelection {
        case 0:
            AnyView(TeacherOverviewTabContent(teacher: .sample0))
        //            AnyView(Color.brown)
        case 1:
            AnyView(LessonOverviewTab())
        case 2:
            AnyView(CurriculumTab())
        default:
            AnyView(Color.brown)
        }
    }
    .frame(maxHeight: .fill, alignment: .top)
}
