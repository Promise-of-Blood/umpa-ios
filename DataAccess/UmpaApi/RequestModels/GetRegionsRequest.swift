// Created for Umpa in 2025

import Foundation

struct GetRegionsRequest: NetworkRequest {
    typealias Response = GetRegionsResponse

    let baseUrl: URL
    let path: String
    let header: HttpHeader
    let method: HttpMethod
    let body: Data?
}
