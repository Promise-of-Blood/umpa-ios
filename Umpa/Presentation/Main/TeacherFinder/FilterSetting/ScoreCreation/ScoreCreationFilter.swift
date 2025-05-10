// Created for Umpa in 2025

import Domain
import Foundation

@Observable
final class ScoreCreationFilter {
    var scoreTypes: Set<ScoreTypeFilter> = []
    var colleges: [College] = []
    var turnaround: TurnaroundFilter = .all
    var fee: ScoreCreationFeeFilter = .all

    func reset() {
        scoreTypes = []
        colleges = []
        turnaround = .all
        fee = .all
    }
}

enum ScoreTypeFilter: Hashable, CaseIterable {
    case fullScore
    case vocal
    case piano
    case guitar
    case bass
    case windInstrument
    case drum
}



enum ScoreCreationFeeFilter: Hashable, CaseIterable {
    case all
    case lessThanOrEqual500000krwPerMusic
    case lessThanOrEqual400000krwPerMusic
    case lessThanOrEqual300000krwPerMusic
    case lessThanOrEqual200000krwPerMusic
    case lessThanOrEqual100000krwPerMusic
    case lessThanOrEqual50000krwPerMusic
    case lessThanOrEqual30000krwPerMusic
}
