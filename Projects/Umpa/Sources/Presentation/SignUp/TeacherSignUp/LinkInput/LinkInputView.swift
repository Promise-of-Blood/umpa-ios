// Created for Umpa in 2025

import BaseFeature
import Domain
import SwiftUI
import UmpaUIKit

struct LinkInputView: View {
  @ObservedObject var signUpModel: TeacherSignUpModel

  var body: some View {
    ScrollView {
      content
    }
  }

  var content: some View {
    VStack(spacing: fs(50)) {
      Text("대표 사이트를 등록해주세요")
        .font(SignUpConstant.titleFont)
        .foregroundStyle(SignUpConstant.titleColor)
        .frame(maxWidth: .infinity, alignment: .leading)

      VStack(spacing: fs(12)) {
        Text("사이트 링크*")
          .font(.pretendardMedium(size: fs(16)))
          .foregroundStyle(UmpaColor.mainBlue)
          .frame(maxWidth: .infinity, alignment: .leading)

        VStack(spacing: fs(18)) {
          ForEach(signUpModel.siteLinks) { link in
            SiteLinkRow(link: Bindable(link)) {
              withAnimation {
                signUpModel.siteLinks.removeAll(where: { $0.id == link.id })
              }
            }
            .id(link.id)
            .transition(.blurReplace)
          }
          if signUpModel.siteLinks.count < Teacher.SiteLinkValidator.maxCount {
            addSiteLinkButton
          }
        }
        .padding(.vertical, fs(12))
      }
    }
    .background(.white)
  }

  var addSiteLinkButton: some View {
    Button(action: didTapAddSiteLinkButton) {
      Image(systemSymbol: .plus)
        .font(.system(size: 36, weight: .bold))
        .foregroundStyle(UmpaColor.lightBlue)
        .frame(maxWidth: .infinity, height: fs(50))
        .background(.white)
        .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
    }
  }

  private func didTapAddSiteLinkButton() {
    guard signUpModel.siteLinks.count < Teacher.SiteLinkValidator.maxCount else { return }
    withAnimation {
      signUpModel.siteLinks.append(SiteLinkModel(link: ""))
    }
  }
}

#Preview {
  VStack(spacing: 0) {
    Color.gray
      .frame(height: 120)
    LinkInputView(signUpModel: TeacherSignUpModel(socialLoginType: .apple))
    Color.gray
      .frame(height: 240)
  }
}
