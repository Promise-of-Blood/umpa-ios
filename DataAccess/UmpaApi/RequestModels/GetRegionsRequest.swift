// Created for Umpa in 2025

import Foundation

struct GetRegionsRequest: NetworkRequest {
    typealias Response = GetRegionsResponse

    let baseUrl: URL = Constant.baseUrl
    let path: String = "api/regions"
    let header: HttpHeader = .empty()
    let method: HttpMethod = .get
    let body: Data? = nil
}
