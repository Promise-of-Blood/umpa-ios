// Created for Umpa in 2025

import Domain
import Foundation

typealias InstrumentFilter = String

@Observable
final class AccompanistFilter {
    var instruments: Set<InstrumentFilter> = []
    var colleges: [College] = []
    var regions: [Region] = []
    var accompanistFee: AccompanistFeeFilter = .all
    var gender: GenderFilter = .all

    func reset() {
        instruments = []
        colleges = []
        regions = []
        accompanistFee = .all
        gender = .all
    }
}

enum AccompanistFeeFilter: Hashable, CaseIterable {
    case all
    case lessThanOrEqual500000krwPerSchool
    case lessThanOrEqual450000krwPerSchool
    case lessThanOrEqual400000krwPerSchool
    case lessThanOrEqual350000krwPerSchool
    case lessThanOrEqual300000krwPerSchool
    case lessThanOrEqual250000krwPerSchool
    case lessThanOrEqual200000krwPerSchool
    case lessThanOrEqual150000krwPerSchool
    case lessThanOrEqual100000krwPerSchool
}
