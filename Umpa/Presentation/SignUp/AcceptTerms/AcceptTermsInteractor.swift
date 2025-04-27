// Created for Umpa in 2025

import Core
import Foundation

protocol AcceptTermsInteractor {
    func moveToNext()
}

final class DefaultAcceptTermsInteractor {
    private let appState: AppState

    private var hasMovedToNext: Bool = false

    init(appState: AppState) {
        self.appState = appState
    }
}

extension DefaultAcceptTermsInteractor: AcceptTermsInteractor {
    func moveToNext() {
        guard !hasMovedToNext else { return }
        hasMovedToNext = true
        appState.routing.loginNavigationPath.append(SignUpRoute.userTypeSelection)
        UmpaLogger.log("회원 유형 선택 화면으로 이동", level: .debug)
    }
}
