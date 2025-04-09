// Created for Umpa in 2025

import SwiftUI

extension NavigationPath {
    public mutating func removeAll() {
        removeLast(count)
    }
}
