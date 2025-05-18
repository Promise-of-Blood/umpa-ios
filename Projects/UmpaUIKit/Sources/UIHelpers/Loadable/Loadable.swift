// MIT License
//
// Copyright (c) 2019 Alexey
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Copyright (c) 2025 Jaewon Yun
// This file has been modified from the original version.

import Combine
import class Core.CancelBag
import Foundation
import SwiftUI

public typealias LoadableBinding<Value> = Binding<Loadable<Value, Error>>

@frozen public enum Loadable<Data, E> where E: Error {
  case notRequested
  case isLoading(last: Data?, cancelBag: CancelBag)
  case loaded(Data)
  case failed(E)

  public var value: Data? {
    switch self {
    case let .loaded(value): value
    case let .isLoading(last, _): last
    default: nil
    }
  }

  public var error: E? {
    switch self {
    case let .failed(error): error
    default: nil
    }
  }
}

public extension Loadable {
  mutating func setIsLoading(cancelBag: CancelBag) {
    self = .isLoading(last: value, cancelBag: cancelBag)
  }

  mutating func cancelLoading(with error: E) {
    switch self {
    case let .isLoading(last, cancelBag):
      cancelBag.cancel()
      if let last {
        self = .loaded(last)
      } else {
        self = .failed(error)
      }
    default: break
    }
  }

  func map<V>(_ transform: (Data) throws -> V) -> Loadable<V, Error> {
    do {
      switch self {
      case .notRequested: return .notRequested
      case let .failed(error): return .failed(error)
      case let .isLoading(value, cancelBag):
        return try .isLoading(last: value.map { try transform($0) },
                              cancelBag: cancelBag)
      case let .loaded(value):
        return try .loaded(transform(value))
      }
    } catch {
      return .failed(error)
    }
  }
}

public protocol SomeOptional {
  associatedtype Wrapped
  func unwrap() throws -> Wrapped
}

struct ValueIsMissingError: Error {
  var localizedDescription: String {
    NSLocalizedString("Data is missing", comment: "")
  }
}

extension Optional: SomeOptional {
  public func unwrap() throws -> Wrapped {
    switch self {
    case let .some(value): return value
    case .none: throw ValueIsMissingError()
    }
  }
}

extension Loadable where Data: SomeOptional {
  public func unwrap() -> Loadable<Data.Wrapped, Error> {
    map { try $0.unwrap() }
  }
}

// MARK: - Equatable

extension Loadable: Equatable where Data: Equatable {
  public static func == (lhs: Loadable<Data, E>, rhs: Loadable<Data, E>) -> Bool {
    switch (lhs, rhs) {
    case (.notRequested, .notRequested): true
    // CancelBag 비교는 생략
    case let (.isLoading(lhsV, _), .isLoading(rhsV, _)): lhsV == rhsV
    case let (.loaded(lhsV), .loaded(rhsV)): lhsV == rhsV
    case let (.failed(lhsE), .failed(rhsE)):
      lhsE.localizedDescription == rhsE.localizedDescription
    default: false
    }
  }
}

extension Publisher {
  public func sinkToLoadable(_ completion: @escaping (Loadable<Output, Failure>) -> Void) -> AnyCancellable {
    sink(receiveCompletion: { subscriptionCompletion in
      if let error = subscriptionCompletion.error {
        completion(.failed(error))
      }
    }, receiveValue: { value in
      completion(.loaded(value))
    })
  }

  public func sinkToLoadable(_ loadable: Binding<Loadable<Output, Failure>>) -> AnyCancellable {
    sinkToLoadable { source in
      loadable.wrappedValue = source
    }
  }
}
