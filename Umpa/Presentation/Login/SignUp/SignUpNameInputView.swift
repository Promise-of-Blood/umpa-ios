// Created for Umpa in 2025

import SwiftUI

struct SignUpNameInputView: View {
    @State private var name: String = ""

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            Text("이름을 입력해주세요")
                .modifier(TitleText())
            Spacer()
            VStack(alignment: .leading) {
                InputFieldLabelText("이름")
                nameTextField
            }
            .padding(.horizontal, 30)
            Spacer()
            NavigationLink {
                SignUpMajorSelectionView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(BackButton())
    }

    var nameTextField: some View {
        TextField(
            "이름",
            text: $name,
            prompt: Text("이름을 입력해주세요")
        )
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hex: "#9E9E9E"))
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
