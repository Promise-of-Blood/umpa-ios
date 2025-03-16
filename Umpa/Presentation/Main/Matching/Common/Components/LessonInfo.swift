// Created for Umpa in 2025

import SwiftUI

struct LessonInfo: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("OOO 선생님")
            Circle()
                .frame(width: 1.5, height: 1.5)
            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                Text("4.5")
            }
            Circle()
                .frame(width: 1.5, height: 1.5)
            Text("음파/음파동")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LessonInfo()
}
