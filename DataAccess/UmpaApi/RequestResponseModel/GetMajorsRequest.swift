// Created for Umpa in 2025

import Domain
import Foundation

struct GetMajorsRequest: NetworkRequest {
    typealias Response = GetMajorsResponse

    let baseUrl: URL = Constant.baseUrl
    let path: String = "api/majors"
    let header: HttpHeader = .empty()
    let method: HttpMethod = .get
    let body: Data? = nil
}

typealias GetMajorsResponse = [MajorDto]

struct MajorDto: Decodable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension MajorDto {
    func toDomain() -> Major? {
        switch name {
        case "피아노":
            return .piano
        case "작곡":
            return .composition
        case "드럼":
            return .drum
        case "베이스":
            return .bass
        case "기타":
            return .guitar
        case "보컬":
            return .vocal
        case "전자음악":
            return .electronicMusic
        case "관악":
            return .windInstrument
        default:
            return nil
        }
    }
}
