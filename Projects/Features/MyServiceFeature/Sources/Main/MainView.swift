// Created for Umpa in 2025

import BaseFeature
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

public struct MainView: View {
  let model: Model

  @State private var navigationPath = NavigationPath()

  public var body: some View {
    NavigationStack(path: $navigationPath) {
      content
        .navigationTitle("프로필/서비스 관리")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: NavigationDestination.self) { destination in
          switch destination {
          case .editProfile:
            EmptyView()
          case .previewProfile:
            EmptyView()
          case .myService:
            EmptyView()
          case .myStudent:
            EmptyView()
          }
        }
    }
    .onAppear(perform: loadProfile)
  }

  var content: some View {
    ScrollView {
      VStack(spacing: fs(30)) {
        TeacherMainProfileCardView(
          model: model.profileCardModel,
          editProfileAction: {
            navigationPath.append(NavigationDestination.editProfile)
          },
          previewProfileAction: {
            navigationPath.append(NavigationDestination.previewProfile)
          }
        )
        if model.needsFilloutRequires {
          requiredFieldGuideSection
        } else {
          myServiceAndStudentLinks
        }
      }
      .padding(.horizontal, fs(20))
      .padding(.vertical, fs(16))
    }
    .scrollBounceBehavior(.basedOnSize)
  }

  var requiredFieldGuideSection: some View {
    VStack(spacing: fs(20)) {
      requiredFieldGuideHeader
      requiredFieldGuideListContent
    }
  }

  var requiredFieldGuideHeader: some View {
    VStack(spacing: fs(14)) {
      Text("서비스 등록 전 프로필 항목을 완성해주세요")
        .font(.pretendardSemiBold(size: fs(16)))
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
      VStack(alignment: .leading, spacing: fs(4)) {
        ProgressView(value: model.progressValue)
          .background(UmpaColor.lightBlue)
          .clipShape(RoundedRectangle(cornerRadius: .infinity))
        Text("\(Int(model.progressValue * 100))% 완료")
          .font(.pretendardSemiBold(size: fs(16)))
          .foregroundStyle(UmpaColor.mainBlue)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  var requiredFieldGuideListContent: some View {
    VStack(spacing: fs(8)) {
      ForEach(model.requiredFieldEntry, id: \.self) { field in
        if let isCompleted = model.requiredFields[field] {
          CompletableItem(isCompleted: .constant(isCompleted), title: field.title) {
            //
          }
        }
      }
    }
  }

  var myServiceAndStudentLinks: some View {
    VStack(spacing: fs(12)) {
      myCard(title: "내가 올린 서비스 목록", secondaryText: "내 서비스 글 확인 및 수정하기") {
        navigationPath.append(NavigationDestination.myService)
      }
      myCard(title: "학생 관리", secondaryText: "매칭된 학생/의뢰인 목록 및 관리") {
        navigationPath.append(NavigationDestination.myStudent)
      }
    }
  }

  func myCard(title: String, secondaryText: String, action: @escaping () -> Void) -> some View {
    let symbolSize: CGFloat = fs(48)
    return Button(action: action) {
      HStack(spacing: fs(20)) {
        Image(systemSymbol: .person)
          .resizable()
          .frame(width: symbolSize, height: symbolSize)
        VStack(alignment: .leading, spacing: fs(8)) {
          Text(title)
            .font(.pretendardSemiBold(size: fs(18)))
            .foregroundStyle(.black)
          Text(secondaryText)
            .font(.pretendardRegular(size: fs(12)))
            .foregroundStyle(UmpaColor.darkGray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal, fs(20))
      .padding(.vertical, fs(28))
      .background(.white)
      .innerRoundedStroke(UmpaColor.lightBlue, cornerRadius: fs(10))
    }
  }

  // MARK: Interaction Methods

  private func loadProfile() {
    //
  }
}

extension MainView {
  enum NavigationDestination {
    case editProfile
    case previewProfile
    case myService
    case myStudent
  }
}

extension MainView {
  @Observable
  final class Model {
    enum RequiredField: CaseIterable {
      case educationVerification
      case profileImage
      case gender
      case representativeExperience
      case lessonRegion
      case siteLink

      var title: String {
        switch self {
        case .educationVerification:
          "학력 인증"
        case .profileImage:
          "프로필 이미지 등록"
        case .gender:
          "성별 선택"
        case .representativeExperience:
          "대표 경력 등록"
        case .lessonRegion:
          "레슨 지역 설정"
        case .siteLink:
          "사이트 링크 추가"
        }
      }
    }

    let profileCardModel: TeacherMainProfileCardView.Model
    var requiredFields: [RequiredField: Bool]

    let requiredFieldEntry: [RequiredField] = [
      .educationVerification,
      .profileImage,
      .gender,
      .representativeExperience,
      .lessonRegion,
      .siteLink,
    ]

    var progressValue: Float {
      let totalFields = requiredFields.count
      let completedFields = requiredFields.filter(\.value).count
      return Float(completedFields) / Float(totalFields)
    }

    var needsFilloutRequires: Bool {
      requiredFields.values.contains(false)
    }

    init(profileCardModel: TeacherMainProfileCardView.Model, requiredFields: [RequiredField: Bool]) {
      self.profileCardModel = profileCardModel
      self.requiredFields = requiredFields
      assert(requiredFields.count == RequiredField.allCases.count,
             "모든 항목에 대해 true/false 값을 설정해야 합니다.")
    }
  }
}

#Preview("필수 항목 입력 필요") {
  MainView(
    model: .init(profileCardModel: .init(name: "장우영 선생님",
                                         profileImageUrl: "",
                                         secondaryInfo: "베이스 · 서울/연남동 ",
                                         experiences: [
                                           "호원대학교 베이스 전공 중퇴",
                                           "서울예술대학교, 서울예술대학교, 서울예술대학교, 서울예술대학교 베이스 전공 재학중",
                                           "AKMU - 롱디 녹음 세션",
                                         ]),
                 requiredFields: [
                   .educationVerification: true,
                   .profileImage: false,
                   .representativeExperience: true,
                   .lessonRegion: false,
                   .siteLink: false,
                   .gender: false,
                 ])
  )
}

#Preview("필수 항목 입력 완료") {
  MainView(
    model: .init(profileCardModel: .init(name: "장우영 선생님",
                                         profileImageUrl: "",
                                         secondaryInfo: "베이스 · 서울/연남동 ",
                                         experiences: [
                                           "호원대학교 베이스 전공 중퇴",
                                           "서울예술대학교, 서울예술대학교, 서울예술대학교, 서울예술대학교 베이스 전공 재학중",
                                           "AKMU - 롱디 녹음 세션",
                                         ]),
                 requiredFields: [
                   .educationVerification: true,
                   .profileImage: true,
                   .representativeExperience: true,
                   .lessonRegion: true,
                   .siteLink: true,
                   .gender: true,
                 ])
  )
}
