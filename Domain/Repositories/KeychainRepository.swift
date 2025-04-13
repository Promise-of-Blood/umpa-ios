// Created for Umpa in 2025

import Foundation

public protocol KeychainRepository {
    func save(_ token: AccessToken)
    func getAccessToken() -> AccessToken?
}
