// Created for Umpa in 2025

import Domain
import Foundation

protocol MajorSelectableModel: ObservableObject {
    var major: Major? { get set }

    func validateMajor() -> Bool
}

extension MajorSelectableModel {
    func validateMajor() -> Bool {
        return major != nil
    }
}
