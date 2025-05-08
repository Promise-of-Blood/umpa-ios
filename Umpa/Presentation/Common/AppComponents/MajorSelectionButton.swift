// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct MajorSelectionButton: View {
    let major: Major
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    static func hidden() -> some View {
        Self(major: Major(name: ""), isSelected: false, action: {})
            .hidden()
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(4)) {
                Image(major.imageResource)
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

                Text(major.name)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension Major {
    var imageResource: ImageResource {
        ImageResource.seeAllIcon
//        switch self {
//        case .piano:
//            return ImageResource(.majorIconPiano)
//        case .vocal:
//            return ImageResource(name: "vocal", bundle: .main)
//        case .composition:
//            return ImageResource(name: "composition", bundle: .main)
//        case .drum:
//            return ImageResource(name: "drum", bundle: .main)
//        case .guitar:
//            return ImageResource(name: "guitar", bundle: .main)
//        case .bass:
//            return ImageResource(name: "bass", bundle: .main)
//        case .brass:
//            return ImageResource(name: "brass", bundle: .main)
//        case .electronicMusic:
//            return ImageResource(name: "electronicMusic", bundle: .main)
//        }
    }
}
