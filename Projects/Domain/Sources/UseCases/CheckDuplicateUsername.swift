// Created for Umpa in 2025

import Combine
import Foundation
import Mockable

@Mockable
public protocol CheckAvailableUsernameUseCase {
    /// 사용 가능한 사용자 이름인지 확인합니다.
    func callAsFunction(_ username: String) -> AnyPublisher<Bool, Error>
}

struct DefaultCheckAvailableUsernameUseCase {}

extension DefaultCheckAvailableUsernameUseCase: CheckAvailableUsernameUseCase {
    public func callAsFunction(_ username: String) -> AnyPublisher<Bool, any Error> {
        fatalError("Not implemented")
    }
}
