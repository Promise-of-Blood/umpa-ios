// Created for Umpa in 2025

import Foundation

public struct ScoreCreationServiceCreateData {
    public let title: String
    public let thumbnail: Data?
    public let majors: [ScoreCreationMajor]
    public let revisionPolicy: RevisionPolicy
    public let turnaround: Turnaround
    public let pricesByMajor: [PriceByMajor]
    public let tools: [CompositionTool]
    public let sampleSheets: [SampleSheet]
    public let serviceDescription: String
}
