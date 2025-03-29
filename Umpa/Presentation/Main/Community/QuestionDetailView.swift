// Created for Umpa in 2025

import SwiftUI

@available(*, deprecated, message: "25/3/28(금) 기획에서 제거됨")
struct QuestionDetailView: View {
    @State private var question: Question

    public init(question: Question) {
        self._question = State(initialValue: question)
    }

    var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
        HStack {
            Text("질문")
            Spacer()
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
        Text("익명의 질문자")
        Text(question.created.formatted())
        Text(question.contents)

        VStack {
            ForEach(question.comments) { comment in
                HStack {
                    Text(comment.writer ?? "익명")
                    Spacer()
                    Text(comment.created.formatted())
                }
                Text(comment.contents)
            }
        }
    }
}

// #Preview {
//    QuestionDetailView(question: .sample0)
// }
