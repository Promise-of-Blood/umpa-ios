// Created for Umpa in 2025

import SwiftUI

struct LessonServiceCard: View {
    let type: String

    var body: some View {
        HStack {
            Text(type)
        }
    }
}

#Preview {
    LessonServiceCard(type: "레슨/피아노")
}
