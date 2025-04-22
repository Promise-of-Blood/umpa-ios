// Created for Umpa in 2025

import Foundation

struct GetCollegesRequest: NetworkRequest {
    typealias Response = GetCollegesResponse

    let baseUrl: URL = Constant.baseUrl
    let path: String = "api/colleges"
    let header: HttpHeader = .empty()
    let method: HttpMethod = .get
    let body: Data? = nil
}
