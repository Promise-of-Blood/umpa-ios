//
//  Task+.swift
//
//  Created by Jaewon Yun on 2023/10/06.
//  Copyright © 2023 woin2ee. All rights reserved.
//

import Foundation

@available(macOS 10.15, iOS 13.0, watchOS 6.0, *)
extension Task where Failure == Never {
    @discardableResult
    public init(
        priority: TaskPriority? = nil,
        operation: @escaping (() async throws -> Success),
        catch: @escaping ((Error) -> Success)
    ) {
        self.init(priority: priority) {
            do {
                return try await operation()
            } catch {
                return `catch`(error)
            }
        }
    }
}
