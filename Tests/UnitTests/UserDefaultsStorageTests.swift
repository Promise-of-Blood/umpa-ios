// Created for Umpa in 2025

@testable import DataAccess
import Foundation
import Testing

final class UserDefaultsStorageTests {
    var sut: UserDefaultsStorage!
    var userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults(suiteName: "Test")!
        sut = UserDefaultsStorage(defaults: userDefaults)
    }

    deinit {
        userDefaults.removeSuite(named: "Test")
    }

    @Test func customModel() async throws {
        let testModel = CustomModel(id: "id", data: "data".data(using: .utf8)!)
        try sut.set(testModel, forKey: "testModel")
        let loadedModel: CustomModel? = try sut.load(key: "testModel")
        #expect(loadedModel == testModel)
    }
    
    @Test func otherSettingRoute() async throws {
        let testData = true
        userDefaults.set(testData, forKey: "test")
        let loadedData: Bool? = try sut.load(key: "test")
        #expect(loadedData == testData)
    }
}

struct CustomModel: StorableItem, Equatable {
    let id: String
    let data: Data

    static func fromData(_ data: Data) throws -> CustomModel {
        try JSONDecoder().decode(Self.self, from: data)
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
