// Created for Umpa in 2025

import Foundation

public struct LessonService: SinglePriceService {
    public let id: String
    public let type: ServiceType
    public let title: String
    public let thumbnail: URL?
    public let rating: Double
    public let author: Teacher
    public let acceptanceReviews: [AcceptanceReview]
    public let reviews: [Review]
    public let serviceDescription: String
    public let subject: Major
    public let badges: [Badge]
    public let price: Int
    public let scheduleType: ScheduleType
    public let availableTimes: [TimesByWeekday<HMTime>]
    public let lessonStyle: LessonStyle
    public let isAvailableOfflineCounseling: Bool
    public let trialPolicy: TrialPolicy
    public let lessonTargets: [TargetStudent]
    public let studioImages: [URL]
    public let curriculum: [CurriculumItem]
    public let status: LessonStatus

    public init(
        id: String,
        type: ServiceType,
        title: String,
        thumbnail: URL?,
        rating: Double,
        author: Teacher,
        acceptanceReviews: [AcceptanceReview],
        reviews: [Review],
        serviceDescription: String,
        subject: Major,
        badges: [Badge],
        price: Int,
        scheduleType: ScheduleType,
        availableTimes: [TimesByWeekday<HMTime>],
        lessonStyle: LessonStyle,
        isAvailableOfflineCounseling: Bool,
        trialPolicy: TrialPolicy,
        lessonTargets: [TargetStudent],
        studioImages: [URL],
        curriculum: [CurriculumItem],
        status: LessonStatus
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.thumbnail = thumbnail
        self.rating = rating
        self.author = author
        self.acceptanceReviews = acceptanceReviews
        self.reviews = reviews
        self.serviceDescription = serviceDescription
        self.subject = subject
        self.badges = badges
        self.price = price
        self.scheduleType = scheduleType
        self.availableTimes = availableTimes
        self.lessonStyle = lessonStyle
        self.isAvailableOfflineCounseling = isAvailableOfflineCounseling
        self.trialPolicy = trialPolicy
        self.lessonTargets = lessonTargets
        self.studioImages = studioImages
        self.curriculum = curriculum
        self.status = status
    }
}

extension LessonService {
    public enum LessonStyle {
        case online
        case offline
        case both
    }

    public struct TargetStudent: Hashable {
        public let description: String

        public init(description: String) {
            self.description = description
        }
    }

    public struct CurriculumItem: Hashable {
        public let title: String
        public let description: String

        public init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }

    public enum LessonStatus {
        case recruiting
        case closed
    }
}
