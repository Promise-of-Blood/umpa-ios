// Created for Umpa in 2025

import Combine
import Core
import Foundation
import SwiftUI

public typealias ValueLoadableBinding<Value> = Binding<ValueLoadable<Value>>

@frozen public enum ValueLoadable<Value> {
    case value(Value)
    case isLoading(last: Value, cancelBag: CancelBag)

    public var value: Value {
        switch self {
        case let .value(value):
            return value
        case let .isLoading(last, _):
            return last
        }
    }

    public var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        case .value:
            return false
        }
    }
}

public extension ValueLoadable {
    mutating func setIsLoading(cancelBag: CancelBag) {
        self = .isLoading(last: value, cancelBag: cancelBag)
    }

    mutating func cancelLoading() {
        switch self {
        case let .isLoading(last, cancelBag):
            cancelBag.cancel()
            self = .value(last)
        default: break
        }
    }
}

// MARK: - Equatable

extension ValueLoadable: Equatable where Value: Equatable {
    public static func == (lhs: ValueLoadable<Value>, rhs: ValueLoadable<Value>) -> Bool {
        switch (lhs, rhs) {
        // CancelBag은 동일성 비교의 의미가 없으므로 값만 비교합니다.
        case let (.isLoading(lhsV, _), .isLoading(rhsV, _)):
            return lhsV == rhsV
        case let (.value(lhsV), .value(rhsV)):
            return lhsV == rhsV
        default:
            return false
        }
    }
}

extension Publisher where Failure == Never {
    public func sinkToLoadable(_ completion: @escaping (ValueLoadable<Output>) -> Void) -> AnyCancellable {
        return sink { output in
            completion(.value(output))
        }
    }

    public func sinkToLoadable(_ loadable: Binding<ValueLoadable<Output>>) -> AnyCancellable {
        return sinkToLoadable { source in
            loadable.wrappedValue = source
        }
    }
}
