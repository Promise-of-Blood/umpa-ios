// Created for Umpa in 2025

import SwiftUI

public extension View {
    /// 바인딩 된 `Loadable` 객체가 에러 상태일 때, 에러를 표시하는 Alert를 표시합니다.
    func errorAlert<T>(_ error: Binding<Loadable<T, some LocalizedError>>) -> some View {
        let errorBinding = error.map<LocalizedError?>(
            get: { _ in
                error.wrappedValue.error
            },
            set: { error in
                if let error {
                    return .failed(error)
                } else {
                    return .notRequested
                }
            }
        )
        return errorAlert(errorBinding)
    }

    func errorAlert(_ error: Binding<(some LocalizedError)?>) -> some View {
        alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue) { _ in
            Button("확인", role: .cancel) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "잠시 후에 다시 시도해 주세요.")
        }
    }
}
