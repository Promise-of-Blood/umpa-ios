//
//  UserDefaultsStorage.swift
//
//  Naver ID Login SDK for iOS Swift
//  Copyright (c) 2025-present NAVER Corp.
//  Apache-2.0
//

// Copyright (c) 2025 Jaewon Yun
// This file has been modified from the original version.

import Core
import Foundation

public final class UserDefaultsStorage: PersistentStorage {
    let defaults: UserDefaults

    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    public func set<T>(_ value: T, forKey key: String) throws where T: StorableItem {
        let data = try value.toData()
        defaults.setValue(data, forKey: key)
    }

    public func load<T>(key: String) throws -> T? where T: StorableItem {
        guard let value = defaults.value(forKey: key) else {
            return nil
        }

        if let rawValue = value as? T {
            return rawValue
        }

        guard let data = value as? Data else {
            UmpaLogger.log("\(value) is an unknown value.", level: .error)
            throw UserProfileStorageError.unknownValue(value)
        }

        return try T.fromData(data)
    }

    public func remove(key: String) throws {
        defaults.removeObject(forKey: key)
    }
}

enum UserProfileStorageError: Error {
    case unknownValue(Any)
}
