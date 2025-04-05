// Created for Umpa in 2025

import Foundation

struct LessonService: SinglePriceService {
    let id: String?
    let type: ServiceType
    let title: String
    let thumbnail: URL?
    let rating: Double
    let author: Teacher
    let acceptanceReviews: [AcceptanceReview]
    let reviews: [Review]
    let serviceDescription: String
    let subject: Major
    let badges: [Badge]
    let price: Int
    let scheduleType: ScheduleType
    let availableTimes: [TimeByDay]
    let lessonStyle: LessonStyle
    let isAvailableOfflineCounseling: Bool
    let trialPolicy: TrialPolicy
    let lessonTargets: [TargetStudent]
    let studioImages: [URL]
    let curriculum: [CurriculumItem]
    let status: LessonStatus
}

struct Badge {
    let title: String
}

enum ScheduleType {
    case byStudent
    case fixed
}

struct TimeByDay {
    let day: WeekDay
    let startTime: HMTime
    let endTime: HMTime
}

struct HMTime {
    let hour: Int
    let minute: Int
}

enum LessonStyle {
    case online
    case offline
    case both
}

enum TrialPolicy {
    case paid
    case free
    case notAvailable
}

struct TargetStudent {
    let description: String
}

struct CurriculumItem {
    let title: String
    let description: String
}

enum LessonStatus {
    case recruiting
    case closed
}

#if MOCK
extension LessonService {
    static let sample0 = LessonService(
        id: "lessonService0",
        type: .lesson,
        title: "가고싶은 학교 무조건 가는 방법",
        thumbnail: nil,
        rating: 5.0,
        author: .sample0,
        acceptanceReviews: [],
        reviews: [
            .sample0,
            .sample1,
        ],
        serviceDescription:
        """
        기초적인 음악 이론부터 
        미디 큐베이스 프로툴 로직 에이블톤 활용등 실용음악적으로 곡 쓰기
        클래식적인 오케스트레이션
        힙합 R&B를 접목해 여러가지 리듬 접목해 곡쓰기
        발라드 동요 영상에 음악을 입히는 방법 

        Music in Music out 기법부터시작해
        기본적인 화성학 을 토대로전통화성학과 재즈화성학의 비슷한점을 찾고 그 차이점을 알아보고
        컴파운드 하모니를 이용한 새로운 사운드 만들기

        관악기나 현악에서만 쓰이는 보이싱을 이용해 피아노 보이싱 연구해보기 등
        관악에서는 피아노 보이싱에 대한 보이싱을 사용할수있는지 에 관한 레슨을 같이 해봅니다

        기존의 4마디패턴으로 곡쓰기 론도형식의 반복되는 음악에서 그 반대의 형식까지 
        음악에서 형식은 왜 중요하고 꼭 쓰지않아도 되는것인가
        제가 연구하고 가진 정보와 지식들을 모두 알려드립니다
        """,
        subject: Major(name: "piano"),
        badges: [
            Badge(title: "학력 인증"),
            Badge(title: "시범 레슨 운영"),
        ],
        price: 100_000,
        scheduleType: .byStudent,
        availableTimes: [],
        lessonStyle: .both,

        isAvailableOfflineCounseling: true,
        trialPolicy: .free,
        lessonTargets: [
            TargetStudent(description: "아무리 해도 기본기가 부족하다고 느껴지는 학생"),
            TargetStudent(description: "코드초견 어떻게 해야하는지 모르겠다 하는 학생"),
        ],
        studioImages: [],
        curriculum: [
            CurriculumItem(title: "1주차", description: "7th chord 2-5-1 A form B form"),
            CurriculumItem(title: "2주차", description: "Major Scale / Minor Scale"),
            CurriculumItem(title: "3주차", description: "ChordTone Solo"),
            CurriculumItem(title: "4주차", description: "Blues Scale"),
            CurriculumItem(title: "5주차", description: "Walking Bass"),
            CurriculumItem(title: "6주차", description: "Walking Bass + Comping"),
            CurriculumItem(title: "7주차", description: "Jazz Ballad"),
            CurriculumItem(title: "8주차", description: "Jazz Ballad 2"),
            CurriculumItem(title: "9주차", description: "Jazz Standard"),
            CurriculumItem(title: "10주차", description: "Jazz Standard 2"),
        ],
        status: .recruiting
    )
}
#endif
