// Created for Umpa in 2025

import Foundation

extension Bundle {
    public var infoPlist: InfoPlist {
        guard let infoPlist = infoDictionary else {
            fatalError("Missing Info.plist")
        }
        return InfoPlist(infoDictionary: infoPlist)
    }
}

extension [String: Any] {}

public struct InfoPlist {
    private let infoDictionary: [String: Any]

    init(infoDictionary: [String: Any]) {
        self.infoDictionary = infoDictionary
    }

    public func value<T>(forKey key: InfoPlistKey) -> T {
        guard let value = infoDictionary[key.rawValue] as? T else {
            fatalError("Missing value for key: \(key.rawValue). Please check Info.plist.")
        }
        return value
    }

    public func string(forKey key: InfoPlistKey) -> String {
        value(forKey: key)
    }
}

public enum InfoPlistKey: String {
    case keychainAccessToken = "KEYCHAIN_ACCESS_TOKEN_KEY_RELEASE"
    case kakaoNativeAppKey = "KAKAO_NATIVE_APP_KEY"
    case baseUrl = "BASE_URL"
}
