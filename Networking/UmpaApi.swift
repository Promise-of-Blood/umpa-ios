// Created for Umpa in 2025

import Foundation

public struct UmpaApi {
    public static let shared = UmpaApi()

    let baseUrl: URL

    var apiUrl: URL {
        baseUrl.appending(path: "api")
    }

    private init() {
        let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
        baseUrl = URL(string: baseUrlString)!
    }

    public func fetchMajors() async -> [Major] {
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

            let decoded = try JSONDecoder().decode([Major].self, from: data)
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

    public func fetchColleges() async -> [College] {
        let path = "colleges"
        let url = apiUrl.appending(path: path)
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            let decoded = try JSONDecoder().decode([College].self, from: data)
            return decoded
        } catch {
            print(error)
        }

        return []
    }
}
