// Created for Umpa in 2025

import Domain
import Foundation

@Observable
final class MRCreationFilter {
    var colleges: [College] = []
    var turnaround: TurnaroundFilter = .all
    var fee: MRCreationFeeFilter = .all

    func reset() {
        colleges = []
        turnaround = .all
        fee = .all
    }
}

enum MRCreationFeeFilter: Hashable, CaseIterable {
    case all
    case lessThanOrEqual500000krwPerMusic
    case lessThanOrEqual400000krwPerMusic
    case lessThanOrEqual300000krwPerMusic
    case lessThanOrEqual200000krwPerMusic
    case lessThanOrEqual100000krwPerMusic
    case lessThanOrEqual50000krwPerMusic
    case lessThanOrEqual30000krwPerMusic
}
