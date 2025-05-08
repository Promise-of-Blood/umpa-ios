// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct LessonSubjectSelectView: View {
    @Injected(\.appState) private var appState

    @Binding var editingSelectedSubjects: Set<LessonSubject>

    private var lessonSubjectFlatList: [LessonSubject] {
        appState.appData.lessonSubjectList
    }

    private let columnCount = 4
    private var rowCount: Int {
        lessonSubjectFlatList.count / columnCount + (lessonSubjectFlatList.count % columnCount > 0 ? 1 : 0)
    }

    private var lessonSubjectGridList: [[LessonSubject]] {
        var result: [[LessonSubject]] = []
        for i in 0 ..< rowCount {
            let startIndex = i * columnCount
            let endIndex = min(startIndex + columnCount, lessonSubjectFlatList.count)
            let subArray = Array(lessonSubjectFlatList[startIndex ..< endIndex])
            result.append(subArray)
        }
        return result
    }

    // MARK: View

    var body: some View {
        content
    }

    var content: some View {
        subjectGrid
    }

    var subjectGrid: some View {
        Grid(verticalSpacing: fs(30)) {
            ForEach(lessonSubjectGridList, id: \.self) { row in
                GridRow {
                    ForEach(row, id: \.self) { subject in
                        LessonSubjectSelectButton(
                            subject: subject,
                            isSelected: editingSelectedSubjects.contains(subject),
                        ) {
                            didTapSubjectButton(subject: subject)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    // MARK: Private Methods

    private func didTapSubjectButton(subject: LessonSubject) {
        if editingSelectedSubjects.contains(subject) {
            editingSelectedSubjects.remove(subject)
        } else {
            editingSelectedSubjects.insert(subject)
        }
    }
}

private struct LessonSubjectSelectButton: View {
    let subject: LessonSubject
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(4)) {
                Image(subject.imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .padding(fs(12))
                    .background(isSelected ? UmpaColor.lightBlue : .white)
                    .innerRoundedStroke(
                        isSelected ? UmpaColor.mainBlue : UmpaColor.lightLightGray,
                        cornerRadius: iconCornerRadius,
                        lineWidth: fs(1.6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))

                Text(subject.name)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension LessonSubject {
    var imageResource: ImageResource {
        ImageResource.seeAllIcon
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LessonSubjectSelectView(editingSelectedSubjects: .constant([]))
}
