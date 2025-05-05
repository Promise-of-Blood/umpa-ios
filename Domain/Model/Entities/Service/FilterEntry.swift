// Created for Umpa in 2025

import Foundation

public protocol FilterEntry: CaseIterable {
    var id: AnyHashable { get }
    var name: String { get }
}

public enum LessonFilterEntry: FilterEntry {
    case subject
    case major
    case college
    case region
    case lessonStyle
    case price
    case gender

    public var id: AnyHashable { self }

    public var name: String {
        switch self {
        case .subject:
            return "레슨 과목"
        case .major:
            return "선생님 전공"
        case .college:
            return "출신 대학"
        case .region:
            return "레슨 지역"
        case .lessonStyle:
            return "과외 방식"
        case .price:
            return "수업료"
        case .gender:
            return "성별"
        }
    }
}

public enum AccompanistFilterEntry: FilterEntry {
    case instrument
    case college
    case region
    case price
    case gender

    public var id: AnyHashable { self }

    public var name: String {
        switch self {
        case .instrument:
            return "반주 악기"
        case .college:
            return "출신 대학"
        case .region:
            return "지역"
        case .price:
            return "가격"
        case .gender:
            return "성별"
        }
    }
}

public enum ScoreCreationFilterEntry: FilterEntry {
    case scoreType
    case college
    case turnaround
    case price

    public var id: AnyHashable { self }

    public var name: String {
        switch self {
        case .scoreType:
            return "악보 유형"
        case .college:
            return "출신 대학"
        case .turnaround:
            return "소요 기간"
        case .price:
            return "가격"
        }
    }
}

public enum MRCreationFilterEntry: FilterEntry {
    case college
    case turnaround
    case price

    public var id: AnyHashable { self }

    public var name: String {
        switch self {
        case .college:
            return "출신 대학"
        case .turnaround:
            return "소요 기간"
        case .price:
            return "가격"
        }
    }
}
