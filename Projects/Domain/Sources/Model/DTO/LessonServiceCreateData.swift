// Created for Umpa in 2025

import Foundation

public struct LessonServiceCreateData {
    /// 제목
    public let title: String
    
    public let thumbnail: Data?
    
    /// 레슨 과목
    public let subject: Major
    
    /// 레슨 비용
    public let price: Int
    
    /// 일정
    public let scheduleType: ScheduleType
    
    public let availableTimes: [TimeByWeekday<HMTime>]
    
    public let lessonStyle: LessonStyle
    
    public let isAvailableOfflineCounseling: Bool
    
    public let trialPolicy: TrialPolicy
    
    public let lessonTargets: [LessonService.TargetStudent]
    
    public let studioImages: [Data]
    
    public let curriculum: [LessonService.CurriculumItem]
}
