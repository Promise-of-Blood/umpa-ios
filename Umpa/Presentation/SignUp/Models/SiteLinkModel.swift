// Created for Umpa in 2025

import Foundation
import SFSafeSymbols
import SwiftUICore

struct SiteLinkModel: Identifiable {
    enum PreDefinedSite: CaseIterable {
        case instagram
        case youtube
        case soundcloud

        var domain: String {
            switch self {
            case .instagram:
                return "instagram.com"
            case .youtube:
                return "youtube.com"
            case .soundcloud:
                return "soundcloud.com"
            }
        }
    }

    let id = UUID()
    var link: String = ""

    var icon: Image {
        for preDefinedSite in PreDefinedSite.allCases {
            if link.contains(preDefinedSite.domain) {
                switch preDefinedSite {
                case .instagram:
                    return Image(systemSymbol: .square)
                case .youtube:
                    return Image(systemSymbol: .square)
                case .soundcloud:
                    return Image(systemSymbol: .square)
                }
            }
        }
        return Image(systemSymbol: .circle) // 기타
    }
}

extension SiteLinkModel {
    func toDomain() -> String {
        return link
    }
}
