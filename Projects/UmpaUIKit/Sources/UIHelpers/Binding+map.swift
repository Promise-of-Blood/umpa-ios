// Created for Umpa in 2025

import SwiftUI

extension Binding {
    /// 현재 Binding의 타입(Value)을 다른 타입(T)으로 변환한 새로운 Binding을 생성합니다.
    /// - Parameters:
    ///   - transform: 기존의 `Value`에서 새로운 타입 `T`로 변환하는 클로저.
    ///   - reverseTransform: 새로운 타입 `T`에서 다시 원래 타입 `Value`로 변환하는 클로저.
    /// - Returns: 변환된 타입 `T`에 해당하는 새로운 Binding.
    public func map<T>(
        get transform: @escaping (Value) -> T,
        set reverseTransform: @escaping (T) -> Value
    ) -> Binding<T> {
        Binding<T>(
            get: { transform(self.wrappedValue) },
            set: { newValue in
                self.wrappedValue = reverseTransform(newValue)
            }
        )
    }
}
