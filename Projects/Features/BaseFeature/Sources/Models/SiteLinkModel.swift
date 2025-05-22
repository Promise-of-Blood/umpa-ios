// Created for Umpa in 2025

import Foundation
import SwiftUI

@Observable
public final class SiteLinkModel: Identifiable {
  public enum PreDefinedSite: CaseIterable {
    case instagram
    case youtube
    case soundcloud

    public var domain: String {
      switch self {
      case .instagram:
        "instagram.com"
      case .youtube:
        "youtube.com"
      case .soundcloud:
        "soundcloud.com"
      }
    }

    public var symbol: Image {
      switch self {
      case .instagram:
        Image(systemName: "square")
      case .youtube:
        Image(systemName: "square")
      case .soundcloud:
        Image(systemName: "square")
      }
    }
  }

  public let id = UUID()
  public var link: String

  public init(link: String) {
    self.link = link
  }

  public var icon: Image {
    if let url = URL(string: link),
       let host = url.host()?.lowercased(),
       let matchedSite = PreDefinedSite.allCases.first(where: { $0.domain == host })
    {
      matchedSite.symbol
    } else {
      Image(systemName: "circle") // FIXME: 기타에 해당하는 리소스 추가
    }
  }
}

extension SiteLinkModel {
  public func toDomain() -> String {
    link
  }
}
