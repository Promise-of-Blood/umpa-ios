// Created for Umpa in 2025

import Domain
import Foundation

protocol MajorSelectable: ObservableObject {
    var major: Major? { get set }

    func validateMajor() -> Bool
}

extension MajorSelectable {
    func validateMajor() -> Bool {
        return major != nil
    }
}
