// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct GenderSettingSheet: SettingSheet {
  @Binding var isPresenting: Bool
  @Binding var truthGender: Gender?

  /// 일시적으로 편집 중인 상태를 나타냅니다. `truthGender`와 동기화됩니다.
  @State private var editableGender: Editable<Gender?>

  private let genderList: [Gender] = [.male, .female]

  init(
    isPresenting: Binding<Bool>,
    truthGender: Binding<Gender?>,
  ) {
    _isPresenting = isPresenting
    _truthGender = truthGender
    editableGender = .confirmed(truthGender.wrappedValue)
  }

  var body: some View {
    InstinctHeightSheet(
      isPresenting: $isPresenting,
      dismissAction: {
        editableGender.cancel()
      }
    ) {
      content
    }
    .onChange(of: truthGender) { _, newValue in
      editableGender.confirm(newValue)
    }
  }

  @ViewBuilder
  var content: some View {
    VStack(spacing: fs(0)) {
      title("성별")

      ToggleButtons.V1(
        selectedItem: Binding<String?>(
          get: {
            editableGender.current?.name
          },
          set: {
            editableGender.setEditing(Gender($0))
          }
        ),
        itemList: genderList.map(\.name)
      )
      .padding(.horizontal, fs(20))
      .padding(.vertical, fs(24))

      acceptButton {
        if let selectedGender = editableGender.current {
          truthGender = selectedGender
          isPresenting = false
        }
      }
      .disabled(editableGender.current == nil)
    }
  }
}

private extension Gender {
  var name: String {
    switch self {
    case .male:
      "남성"
    case .female:
      "여성"
    }
  }

  init?(_ name: String?) {
    guard let name, let matched = Self.allCases.first(where: { $0.name == name }) else {
      return nil
    }
    self = matched
  }
}

#Preview {
  @Previewable @State var isPresenting = false
  @Previewable @State var gender: Gender? = nil

  ZStack {
    VStack(spacing: 30) {
      Button("Change to nil") {
        gender = nil
      }
      Button("Change to male") {
        gender = .male
      }
      Button("Present") {
        isPresenting = true
      }
    }
    Spacer()
    GenderSettingSheet(isPresenting: $isPresenting, truthGender: $gender)
  }
}
