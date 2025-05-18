// Created for Umpa in 2025

/// 레슨 과목
public struct LessonSubject: Hashable, Decodable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
