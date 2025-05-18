// Created for Umpa in 2025

import Foundation

public struct HttpHeader {
    public let fields: [HttpHeaderField]

    private init() {
        self.fields = []
    }

    public init(fields: [HttpHeaderField]) {
        self.fields = fields
    }

    public static func empty() -> HttpHeader {
        HttpHeader()
    }

    public func toDictionary() -> [String: String] {
        var dictionary = [String: String]()
        for field in fields {
            dictionary[field.key] = field.value
        }
        return dictionary
    }
}

public struct HttpHeaderField {
    let key: String
    let value: String
}

extension HttpHeaderField {
    public static func contentType(_ value: String) -> HttpHeaderField {
        return HttpHeaderField(key: "Content-Type", value: value)
    }

    public static func contentType(_ contentType: ContentType) -> HttpHeaderField {
        return HttpHeaderField(key: "Content-Type", value: contentType.rawValue)
    }

    public static func userAgent(_ value: String) -> HttpHeaderField {
        return HttpHeaderField(key: "User-Agent", value: value)
    }

    public static func authorization(type: TokenType, _ value: String) -> HttpHeaderField {
        return HttpHeaderField(key: "Authorization", value: "\(type.rawValue) \(value)")
    }
}

public enum ContentType: String {
    case json = "application/json"
}

public enum TokenType: String {
    case bearer = "Bearer"
}
