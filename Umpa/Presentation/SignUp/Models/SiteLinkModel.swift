// Created for Umpa in 2025

import Foundation
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

        var symbol: Image {
            switch self {
            case .instagram:
                return Image(systemName: "square")
            case .youtube:
                return Image(systemName: "square")
            case .soundcloud:
                return Image(systemName: "square")
            }
        }
    }

    let id = UUID()
    var link: String = ""

    var icon: Image {
        if let matchedSite = PreDefinedSite.allCases
            .first(where: { link.localizedCaseInsensitiveContains($0.domain) })
        {
            return matchedSite.symbol
        } else {
            return Image(systemName: "circle")
        }
    }
}

extension SiteLinkModel {
    func toDomain() -> String {
        return link
    }
}
