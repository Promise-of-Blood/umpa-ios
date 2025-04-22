// Created for Umpa in 2025

import Foundation

struct GetMajorsRequest: NetworkRequest {
    typealias Response = GetMajorsResponse

    let baseUrl: URL = Constant.baseUrl
    let path: String = "api/majors"
    let header: HttpHeader = .empty()
    let method: HttpMethod = .get
    let body: Data? = nil
}
