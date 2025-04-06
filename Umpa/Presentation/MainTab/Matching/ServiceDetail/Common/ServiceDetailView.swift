// Created for Umpa in 2025

import SwiftUI

protocol ServiceDetailView: View {
    var bottomActionBarHeight: CGFloat { get }
}

extension ServiceDetailView {
    var bottomActionBarHeight: CGFloat { fs(64) }
}
