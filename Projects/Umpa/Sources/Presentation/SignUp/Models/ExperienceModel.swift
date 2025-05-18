// Created for Umpa in 2025

import Domain
import Foundation

struct ExperienceModel: Identifiable {
    let id = UUID()
    var title: String
    var startDate: YMDate
    var endDate: YMDate
    var isRepresentative: Bool

    var period: String {
        "\(startDate.year).\(startDate.month) ~ \(endDate.year).\(endDate.month)"
    }

    func toDomain() -> Experience? {
        return Experience(
            title: title,
            startDate: startDate,
            endDate: endDate,
            isRepresentative: isRepresentative
        )
    }
}

#if DEBUG
extension ExperienceModel {
    public static let sample0 = ExperienceModel(
        title: "2020 삼성호암상 예술상",
        startDate: YMDate(year: 2020, month: 1)!,
        endDate: YMDate(year: 2022, month: 1)!,
        isRepresentative: true
    )

    public static let sample1 = ExperienceModel(
        title: "2020 삼성호암상 예술상",
        startDate: YMDate(year: 2020, month: 1)!,
        endDate: YMDate(year: 2022, month: 1)!,
        isRepresentative: false
    )
}
#endif
