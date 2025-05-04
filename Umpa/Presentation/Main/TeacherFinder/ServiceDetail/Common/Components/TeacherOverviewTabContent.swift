// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

struct TeacherOverviewTabContent: View {
    let teacher: Teacher

    var body: some View {
        content
            .background(.white)
    }

    var content: some View {
        VStack(spacing: fs(14)) {
            keyphraseText
            card
        }
        .padding(.horizontal, fs(30))
        .padding(.vertical, fs(24))
    }

    var keyphraseText: some View {
        Text(teacher.keyphrase)
            .fontWithLineHeight(font: .pretendardSemiBold(size: fs(15)), lineHeight: fs(24))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, fs(6))
    }

    var card: some View {
        let header =
            HStack(spacing: fs(14)) {
                AsyncImage(url: teacher.profileImage) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: fs(50), height: fs(50))
                .clipShape(Circle())

                VStack(spacing: fs(6)) {
                    Text(teacher.name)
                    HStack(spacing: fs(4)) {
                        ForEach(teacher.links, id: \.self) { _ in
                            // TODO: 유튜브 / 인스타 등 아이콘 구현
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        return VStack(spacing: fs(24)) {
            header
            VStack(spacing: fs(26)) {
                experiences
                Text(teacher.introduction)
                    .fontWithLineHeight(font: .pretendardRegular(size: fs(13)), lineHeight: fs(22))
            }
        }
        .padding(.horizontal, fs(12))
        .padding(.vertical, fs(20))
        .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: fs(10), lineWidth: fs(1))
    }

    var experiences: some View {
        VStack(alignment: .leading, spacing: fs(6)) {
            IndexingForEach(teacher.experiences) { _, experience in
                HStack {
                    ZStack {
                        // TODO: 아이콘 svg 로 변경 필요 (후순위)
                        Image(systemName: "checkmark.circle.fill")
                            .frame(width: fs(14), height: fs(14))
                            .foregroundStyle(UmpaColor.mainBlue)
                    }
                    Text(experience.title)
                        .font(.pretendardMedium(size: fs(13)))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    TeacherOverviewTabContent(teacher: .sample0)
        .padding()
        .background(.gray)
}
#endif
