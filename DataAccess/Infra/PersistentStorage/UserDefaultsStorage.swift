//
//  UserDefaultsStorage.swift
//
//  Naver ID Login SDK for iOS Swift
//  Copyright (c) 2025-present NAVER Corp.
//  Apache-2.0
//

// Copyright (c) 2025 Jaewon Yun
// This file has been modified from the original version.

import Foundation

public final class UserDefaultsStorage: PersistentStorage {
    let defaults: UserDefaults

    public init() {
        self.defaults = UserDefaults.standard
    }

    public func set<T>(_ value: T, forKey key: String) throws where T: StorableItem {
        defaults[key] = value
    }

    public func load<T>(key: String) throws -> T? where T: StorableItem {
        return defaults[key]
    }

    public func remove(key: String) throws {
        defaults.removeObject(forKey: key)
    }
}

extension UserDefaults {
    subscript<T: StorableItem>(key: String) -> T? {
        get { value(forKey: key) as? T }
        set { set(newValue, forKey: key) }
    }
}
