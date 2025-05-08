// Created for Umpa in 2025

import Foundation

protocol FilterEntry: CaseIterable {
    var id: AnyHashable { get }
    var name: String { get }
}

enum LessonFilterEntry: FilterEntry {
    case subject
    case major
    case college
    case region
    case lessonStyle
    case lessonFee
    case gender

    var id: AnyHashable { self }

    var name: String {
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
        case .lessonFee:
            return "수업료"
        case .gender:
            return "성별"
        }
    }
}

enum AccompanistFilterEntry: FilterEntry {
    case instrument
    case college
    case region
    case price
    case gender

    var id: AnyHashable { self }

    var name: String {
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

enum ScoreCreationFilterEntry: FilterEntry {
    case scoreType
    case college
    case turnaround
    case price

    var id: AnyHashable { self }

    var name: String {
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

enum MRCreationFilterEntry: FilterEntry {
    case college
    case turnaround
    case price

    var id: AnyHashable { self }

    var name: String {
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
