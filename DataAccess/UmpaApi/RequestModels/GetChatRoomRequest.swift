// Created for Umpa in 2025

import Foundation

struct GetChatRoomRequest: NetworkRequest {
    typealias Response = GetChatRoomResponse

    let baseUrl: URL = Constant.baseUrl
    let path: String
    let header: HttpHeader = .empty()
    let method: HttpMethod = .get
    let body: Data? = nil

    init(id: String) {
        path = "api/chatrooms/\(id)"
    }
}
