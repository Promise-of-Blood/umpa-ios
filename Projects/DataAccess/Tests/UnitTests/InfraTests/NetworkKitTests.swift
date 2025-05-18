// Created for Umpa in 2025

@testable import DataAccess
import Foundation
import Testing

struct NetworkKitTests {
  @Test("URLRequest 변환 테스트")
  func toURLRequest() async throws {
    // Given
    let networkRequest = TestingNetworkRequest.test()

    // When
    let urlRequest = networkRequest.toURLRequest()

    // Then
    #expect(urlRequest.url?.absoluteString == "\(Constant.baseUrl.absoluteString)/\(networkRequest.path)")
    #expect(urlRequest.httpMethod == networkRequest.method.rawValue)
    #expect(urlRequest.allHTTPHeaderFields == networkRequest.header.toDictionary())
    #expect(urlRequest.httpBody == networkRequest.body)
  }
}

struct TestingNetworkRequest: NetworkRequest {
  typealias Response = TestingNetworkResponse
  let baseUrl: URL
  let path: String
  let header: DataAccess.HttpHeader
  let method: DataAccess.HttpMethod
  let body: Data?

  init(
    baseUrl: URL,
    path: String,
    header: DataAccess.HttpHeader,
    method: DataAccess.HttpMethod,
    body: Data?,
  ) {
    self.baseUrl = baseUrl
    self.path = path
    self.header = header
    self.method = method
    self.body = body
  }

  static func test(
    baseUrl: URL = Constant.baseUrl,
    path: String = "test",
    header: DataAccess.HttpHeader = .empty(),
    method: DataAccess.HttpMethod = .get,
    body: Data? = nil,
  ) -> TestingNetworkRequest {
    TestingNetworkRequest(
      baseUrl: baseUrl,
      path: path,
      header: header,
      method: method,
      body: body
    )
  }
}

struct TestingNetworkResponse: NetworkResponse {}
