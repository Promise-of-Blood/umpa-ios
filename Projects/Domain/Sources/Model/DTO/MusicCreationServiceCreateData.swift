// Created for Umpa in 2025

import Foundation

public struct MusicCreationServiceCreateData {
    public let title: String
    public let thumbnail: Data?
    public let serviceDescription: String
    public let price: Int
    public let chargeDescription: String?
    public let tools: [MusicCreationTool]
    public let turnaround: Turnaround
    public let revisionPolicy: RevisionPolicy
    public let sampleMusics: [SampleMusic]
}
