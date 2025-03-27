// Created for Umpa in 2025

import Foundation

struct LessonService {
    let baseInfo: ServiceCommonInfo
}

#if DEBUG
extension LessonService {
    static let sample0 = LessonService(
        baseInfo: ServiceCommonInfo(id: "service0")
    )
}
#endif
