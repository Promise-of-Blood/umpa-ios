//
//  UmpaTests.swift
//  UmpaTests
//
//  Created by 공명선 on 1/10/25.
//

import Networking
import Testing
@testable import Umpa

struct UmpaTests {
    let api = UmpaApi.shared

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.

        let majors = await api.fetchMajors()
        #expect(majors.count > 0)

        let regions = await api.fetchRegions()
        #expect(regions.count > 0)

        let colleges = await api.fetchColleges()
        #expect(colleges.count > 0)
    }
}
