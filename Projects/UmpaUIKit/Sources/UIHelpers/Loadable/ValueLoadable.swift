// Created for Umpa in 2025

import Combine
import class Core.CancelBag
import Foundation
import SwiftUI

public typealias ValueLoadableBinding<Value> = Binding<ValueLoadable<Value>>

@frozen public enum ValueLoadable<Value> {
  case value(Value)
  case isLoading(last: Value, cancelBag: CancelBag)

  public var value: Value {
    get {
      switch self {
      case let .value(value):
        value
      case let .isLoading(last, _):
        last
      }
    }
    set {
      self = .value(newValue)
    }
  }

  public var isLoading: Bool {
    switch self {
    case .isLoading:
      true
    case .value:
      false
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
      lhsV == rhsV
    case let (.value(lhsV), .value(rhsV)):
      lhsV == rhsV
    default:
      false
    }
  }
}

extension Publisher where Failure == Never {
  public func sinkToLoadable(_ completion: @escaping (ValueLoadable<Output>) -> Void) -> AnyCancellable {
    sink { output in
      completion(.value(output))
    }
  }

  public func sinkToLoadable(_ loadable: Binding<ValueLoadable<Output>>) -> AnyCancellable {
    sinkToLoadable { source in
      loadable.wrappedValue = source
    }
  }
}
