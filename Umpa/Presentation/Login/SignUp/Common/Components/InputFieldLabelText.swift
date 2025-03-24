// Created for Umpa in 2025

import SwiftUI

struct InputFieldLabelText: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .medium))
    }
}
