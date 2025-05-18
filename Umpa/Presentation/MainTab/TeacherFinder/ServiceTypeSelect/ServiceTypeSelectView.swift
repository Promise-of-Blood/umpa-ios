// Created for Umpa in 2025

import BaseFeature
import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct ServiceTypeSelectView: View {
  private let horizontalPadding: CGFloat = fs(22)
  private let serviceTypeList: [ServiceType] = [.lesson, .accompanist, .scoreCreation, .mrCreation]

  var body: some View {
    content
  }

  var content: some View {
    ScrollView {
      VStack(spacing: fs(50)) {
        Text("원하는 서비스를 선택해주세요")
          .font(.pretendardBold(size: fs(20)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
        serviceTypeListView
      }
      .padding(.horizontal, horizontalPadding)
      .padding(.top, fs(30))
    }
    .background(.white)
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }

  var serviceTypeListView: some View {
    VStack(spacing: fs(20)) {
      ForEach(serviceTypeList, id: \.self) { serviceType in
        ServiceTypeCard(serviceType: serviceType)
      }
    }
  }
}

private struct ServiceTypeCard: View {
  @Environment(AppState.self) private var appState

  let serviceType: ServiceType

  private let symbolSize: CGFloat = fs(80)
  private let cornerRadius: CGFloat = fs(15)

  var body: some View {
    Button(action: didTap) {
      HStack(alignment: .top, spacing: fs(20)) {
        Color.gray
          .frame(width: symbolSize, height: symbolSize)
        VStack(alignment: .leading, spacing: fs(10)) {
          Text(serviceType.name)
            .font(.pretendardBold(size: fs(18)))
            .foregroundStyle(.black)
          Text(serviceType.description)
            .font(.pretendardMedium(size: fs(14)))
            .foregroundStyle(.black)
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, fs(28))
      .padding(.vertical, fs(20))
      .background(.white)
      .innerRoundedStroke(UmpaColor.lightBlue, cornerRadius: cornerRadius)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
  }

  private func didTap() {
    withAnimation(.easeInOut) {
      appState.userData.teacherFinder.selectedServiceType = serviceType
      appState.userData.teacherFinder.hasDisplayedServiceTypeSelectOnBoarding = true
    }
  }
}

private extension ServiceType {
  var name: String {
    switch self {
    case .lesson:
      "레슨"
    case .accompanist:
      "입시 반주"
    case .scoreCreation:
      "악보 제작"
    case .mrCreation:
      "MR 제작"
    }
  }

  var description: String {
    switch self {
    case .lesson:
      "실력있는 음파 선생님들과의 1:1 맞춤 레슨"
    case .accompanist:
      "전문 반주자와 함께하는 입시 반주"
    case .scoreCreation:
      "맞춤형 악보 편곡 및 제작"
    case .mrCreation:
      "고품질 반주용 음원 제작"
    }
  }
}

#Preview {
  ServiceTypeSelectView()
}
