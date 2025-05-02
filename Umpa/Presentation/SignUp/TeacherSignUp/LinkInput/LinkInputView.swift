// Created for Umpa in 2025

import SwiftUI

struct LinkInputView: View {
    @ObservedObject var signUpModel: TeacherSignUpModel

    private let maxLinkCount = 5

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
                    ForEach($signUpModel.siteLinks) { link in
                        SiteLinkRow(link: link) {
                            withAnimation {
                                signUpModel.siteLinks.removeAll(where: { $0.id == link.id })
                            }
                        }
                        .id(link.id)
                        .transition(.blurReplace)
                    }
                    if signUpModel.siteLinks.count < maxLinkCount {
                        addSiteLinkButton
                    }
                }
                .padding(.vertical, fs(12))
            }
        }
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
        guard signUpModel.siteLinks.count < maxLinkCount else { return }
        withAnimation {
            signUpModel.siteLinks.append(SiteLinkModel())
        }
    }
}

private struct SiteLinkRow: View {
    @Binding var link: SiteLinkModel

    let discardAction: () -> Void

    @State private var isShowingDeleteConfirm = false

    var body: some View {
        HStack(spacing: fs(10)) {
            link.icon

            TextField("사이트 링크", text: $link.link, prompt: Text("사이트 링크"))
                .font(.pretendardMedium(size: fs(15)))
                .foregroundStyle(UmpaColor.darkGray)
                .textInputAutocapitalization(.never)

            Button(action: { isShowingDeleteConfirm = true }) {
                Image(systemSymbol: .trash)
                    .foregroundStyle(.red)
                    .font(.system(size: 16, weight: .medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, fs(20))
        .padding(.vertical, fs(18))
        .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
        .confirmationDialog("이 링크를 삭제하시겠습니까?", isPresented: $isShowingDeleteConfirm) {
            Button("삭제", role: .destructive, action: discardAction)
            Button("취소", role: .cancel) {}
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
