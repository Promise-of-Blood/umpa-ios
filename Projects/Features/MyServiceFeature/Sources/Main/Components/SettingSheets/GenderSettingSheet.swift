// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct GenderSettingSheet: SettingSheet {
  @Binding var isPresenting: Bool

  let acceptAction: (Gender) -> Void

  @State private var editableGender: Editable<Gender?>

  private let genderList: [Gender] = [.male, .female]

  init(isPresenting: Binding<Bool>, initial: Gender?, acceptAction: @escaping (Gender) -> Void) {
    _isPresenting = isPresenting
    editableGender = .confirmed(initial)
    self.acceptAction = acceptAction
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
  }

  @ViewBuilder
  var content: some View {
    VStack(spacing: fs(0)) {
      Text("성별")
        .font(titleFont)
        .padding(.top, fs(20))

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
      .padding(.vertical, fs(18))

      acceptButton {
        if let selectedGender = editableGender.current {
          acceptAction(selectedGender)
          editableGender.confirm(selectedGender)
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

  ZStack {
    Button("Present") {
      isPresenting = true
    }
    Spacer()
    GenderSettingSheet(isPresenting: $isPresenting, initial: nil) {
      print("Selected gender : \($0)")
    }
  }
}
