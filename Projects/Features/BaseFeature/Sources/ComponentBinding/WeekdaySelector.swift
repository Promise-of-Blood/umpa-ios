// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

extension Binding where Value == [Weekday] {
  public var binding: Binding<[WeekdaySelector.Weekday]> {
    Binding<[WeekdaySelector.Weekday]>(
      get: {
        wrappedValue.map { weekday in
          switch weekday {
          case .mon: .mon
          case .tue: .tue
          case .wed: .wed
          case .thu: .thu
          case .fri: .fri
          case .sat: .sat
          case .sun: .sun
          }
        }
      },
      set: { newValue in
        wrappedValue = newValue.map { weekday in
          switch weekday {
          case .mon: .mon
          case .tue: .tue
          case .wed: .wed
          case .thu: .thu
          case .fri: .fri
          case .sat: .sat
          case .sun: .sun
          }
        }
      }
    )
  }
}
