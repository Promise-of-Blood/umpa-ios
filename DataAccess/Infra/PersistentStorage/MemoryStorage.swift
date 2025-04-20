//
//  MemoryStorage.swift
//
//  Naver ID Login SDK for iOS Swift
//  Copyright (c) 2025-present NAVER Corp.
//  Apache-2.0
//

// Copyright (c) 2025 Jaewon Yun
// This file has been modified from the original version.

import Foundation

public final class MemoryStorage: PersistentStorage {
    private var storage: [String: Data] = [:]
    private let lock = NSLock()

    public init() {}

    public func set<T: StorableItem>(_ value: T, forKey key: String) throws {
        lock.lock()
        defer { lock.unlock() }

        storage[key] = try value.toData()
    }

    public func load<T: StorableItem>(key: String) throws -> T? {
        lock.lock()
        defer { lock.unlock() }

        guard let data = storage[key] else { return nil }
        return try T.fromData(data)
    }

    public func remove(key: String) throws {
        lock.lock()
        defer { lock.unlock() }

        storage.removeValue(forKey: key)
    }
}
