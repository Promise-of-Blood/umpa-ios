// Created for Umpa in 2025. Jaewon Yun.

/// 일시적으로 편집 중인 상태를 표현할 수 있는 enum입니다.
///
/// ```swift
/// // 최초 확정 값으로 초기화
/// var title = Editable.confirmed("My Post")
///
/// // 1) 편집 시작 ─ 현재 값만 바뀌고 lastConfirmed는 그대로
/// title.setEditing("My Draft")
/// print(title.current)       // "My Draft"
/// print(title.lastConfirmed) // "My Post"
///
/// // 2) 편집 취소 ─ 마지막 확정 값으로 롤백
/// title.cancel()
/// print(title.current)       // "My Post"
///
/// // 3) 다시 편집 후 확정
/// title.setEditing("Final Post")
/// title.confirm("Final Post")
/// print(title.current)       // "Final Post"
/// print(title.lastConfirmed) // "Final Post"
/// ```
public enum Editable<Value> {
  /// 편집 중인 상태입니다. 마지막으로 확정된 값을 보존합니다.
  case editing(Value, lastConfirmed: Value)
  /// 확정된 상태입니다.
  case confirmed(Value)

  /// 편집 상태로 값을 설정합니다. 자동으로 마지막 확정된 값을 보존합니다.
  public mutating func setEditing(_ value: Value) {
    self = .editing(value, lastConfirmed: lastConfirmed)
  }

  /// 편집을 취소하고 마지막으로 확정된 값으로 되돌립니다.
  public mutating func cancel() {
    switch self {
    case let .editing(_, lastConfirmed):
      self = .confirmed(lastConfirmed)
    case .confirmed:
      return
    }
  }

  /// 값을 확정합니다. `confirmed` case를 할당하는 것과 동일합니다.
  public mutating func confirm(_ value: Value) {
    self = .confirmed(value)
  }

  /// 현재 값입니다.
  public var current: Value {
    switch self {
    case let .editing(value, _):
      value
    case let .confirmed(value):
      value
    }
  }

  /// 마지막으로 확정된 값입니다.
  public var lastConfirmed: Value {
    switch self {
    case let .editing(_, lastConfirmed):
      lastConfirmed
    case let .confirmed(value):
      value
    }
  }
}
