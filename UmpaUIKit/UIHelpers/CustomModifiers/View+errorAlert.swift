// Created for Umpa in 2025

import SwiftUI

public extension View {
    /// 바인딩 된 `Loadable` 객체가 에러 상태일 때, 에러를 표시하는 Alert를 표시합니다.
    ///
    /// 확인 버튼을 눌러서 Alert를 닫을 때 바인딩 된 `Loadable` 객체는 `.notRequested` 상태로 변경됩니다.
    func errorAlert<T>(_ error: Binding<Loadable<T, some LocalizedError>>) -> some View {
        let errorBinding = error.map(
            get: { _ in
                error.wrappedValue.error
            },
            set: { newError in
                // 에러가 발생했을 경우
                if let newError {
                    return .failed(newError)
                }
                // 에러가 해결됐고, 이전 상태가 .failed였을 경우
                else if case .failed = error.wrappedValue {
                    return .notRequested
                }
                // 다른 상태는 유지
                else {
                    return error.wrappedValue
                }
            }
        )
        return errorAlert(errorBinding)
    }

    /// 바인딩 된 에러 객체가 nil이 아닐 때, 에러를 표시하는 Alert를 표시합니다.
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
