// Created for Umpa in 2025

import Foundation

protocol FilterEntry: Identifiable {
    var name: String { get }
}

enum LessonFilterEntry: FilterEntry {
    case subject
    case major
    case college
    case region
    case lessonStyle
    case price
    case gender

    var id: LessonFilterEntry { self }

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
        case .price:
            return "수업료"
        case .gender:
            return "성별"
        }
    }

    static var orderedList: [LessonFilterEntry] {
        [
            .subject,
            .major,
            .college,
            .region,
            .lessonStyle,
            .price,
            .gender,
        ]
    }
}

// enum AccompanistFilterEntry {
//    case instrument
//    case college
//    case region
//    case price
//    case gender
// }
