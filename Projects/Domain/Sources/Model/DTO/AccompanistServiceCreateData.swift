// Created for Umpa in 2025

import Foundation

public struct AccompanistServiceCreateData {
    public let title: String
    public let thumbnail: Data?
    public let serviceDescription: String
    public let price: Int
    public let chargeDescription: String?
    public let instruments: [Major]
    public let ensemblePolicy: AccompanistService.EnsemblePolicy
    public let isServingMusicRecorded: Bool
    public let ensemblePlace: AccompanistService.EnsemblePlace
}
