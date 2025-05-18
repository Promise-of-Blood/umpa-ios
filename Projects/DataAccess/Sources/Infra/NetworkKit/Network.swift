// Created for Umpa in 2025

import Combine
import Foundation

public protocol Network {
    func request<T: NetworkRequest>(_ request: T) async throws -> T.Response
    func requestPublisher<T: NetworkRequest>(_ request: T) -> AnyPublisher<T.Response, Error>
}

public struct DefaultNetwork: Network {
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func request<T: NetworkRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = request.toURLRequest()
        let (data, response) = try await session.data(for: urlRequest)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw NetworkError.invalidResponse
//        }
//
//        guard (200 ... 299).contains(httpResponse.statusCode) else {
//            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
//        }

        return try JSONDecoder().decode(T.Response.self, from: data)
    }

    public func requestPublisher<T: NetworkRequest>(_ request: T) -> AnyPublisher<T.Response, any Error> {
        return Future { promise in
            Task {
                let response = try await self.request(request)
                promise(.success(response))
            } catch: { error in
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
