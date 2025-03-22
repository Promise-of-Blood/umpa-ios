// Created for Umpa in 2025

import Components
import SwiftUI

struct SignUpNameInputView: View {
    @State private var name: String = ""

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            Text("이름을 입력해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                InputFieldLabelText("이름")
                nameTextField
            }
            Spacer()
            NavigationLink {
                SignUpMajorSelectionView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(NavigationBackButton(.arrowBack))
    }

    var nameTextField: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundStyle(UmpaColor.lightGray)
            TextField(
                "이름",
                text: $name,
                prompt: Text("이름을 입력해주세요")
            )
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(UmpaColor.lightGray)
        }
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        SignUpNameInputView()
    }
}
