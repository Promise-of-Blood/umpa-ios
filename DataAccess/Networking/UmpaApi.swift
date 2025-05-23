// Created for Umpa in 2025

import Foundation

public struct UmpaApi {
    let baseUrl: URL

    var apiUrl: URL {
        baseUrl.appending(path: "api")
    }

    public init() {
        let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
        baseUrl = URL(string: baseUrlString)!
    }

    public func fetchMajors() async -> [MajorResponse] {
        let path = "majors"
        let url = apiUrl.appending(path: path)
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

//            let httpResponse = response as! HTTPURLResponse

//            let statusCode = httpResponse.statusCode
//            let allHeaderFields = httpResponse.allHeaderFields
//            let mimeType = httpResponse.mimeType

            let decoded = try JSONDecoder().decode([MajorResponse].self, from: data)
            return decoded
        } catch {
            print(error)
        }

        return []
    }

    public func fetchRegions() async -> [RegionalLocalGovernment] {
        let path = "regions"
        let url = apiUrl.appending(path: path)
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            let decoded = try JSONDecoder().decode([RegionalLocalGovernment].self, from: data)
            return decoded
        } catch {
            print(error)
        }

        return []
    }

    public func fetchColleges() async -> [CollegeResponse] {
        let path = "colleges"
        let url = apiUrl.appending(path: path)
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            let decoded = try JSONDecoder().decode([CollegeResponse].self, from: data)
            return decoded
        } catch {
            print(error)
        }

        return []
    }
}
