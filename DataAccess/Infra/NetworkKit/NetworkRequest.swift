// Created for Umpa in 2025

import Foundation

public protocol NetworkRequest {
    associatedtype Response: Decodable

    var baseUrl: URL { get }
    var path: String { get }
    var header: HttpHeader { get }
    var method: HttpMethod { get }
    var body: Data? { get }
}

extension NetworkRequest {
    func toURLRequest() -> URLRequest {
        let url = baseUrl.appending(component: path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header.dictionary
        urlRequest.httpBody = body
        return urlRequest
    }
}
