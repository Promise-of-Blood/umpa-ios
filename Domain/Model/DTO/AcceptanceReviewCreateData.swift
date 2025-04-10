// Created for Umpa in 2025

import Foundation

public struct AcceptanceReviewCreateData {
    public let title: String
    public let content: String
    public let colleges: [College]
    public let major: Major
    public let images: [Data]
    public let taggedTeachers: [Teacher.ID]
}
