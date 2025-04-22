// Created for Umpa in 2025

import SwiftUI

struct BasicSettingsListItem: View {
    let primaryText: String

    var body: some View {
        self.content
            .settingsListItem()
    }

    var content: some View {
        Text(self.primaryText)
            .modifier(PrimaryTextModifier())
    }
}

struct NavigatingSettingsListItem: View {
    let primaryText: String

    var body: some View {
        self.content
            .settingsListItem()
    }

    var content: some View {
        HStack {
            Text(self.primaryText)
                .modifier(PrimaryTextModifier())
            Spacer()
            // FIXME: 실제 아이콘 리소스로 교체
            Image(systemName: "chevron.right")
        }
    }
}

struct ToggleSettingsListItem: View {
    let primaryText: String
    @Binding var isOn: Bool

    var body: some View {
        self.content
            .settingsListItem()
    }

    var content: some View {
        HStack {
            Text(self.primaryText)
                .modifier(PrimaryTextModifier())
            Spacer()
            ToggleSwitch(isOn: self.$isOn)
        }
    }
}

struct ValueSettingsListItem: View {
    let primaryText: String
    let valueText: String

    var body: some View {
        self.content
            .settingsListItem()
    }

    var content: some View {
        HStack {
            Text(self.primaryText)
                .modifier(PrimaryTextModifier())
            Spacer()
            Text(self.valueText)
                .font(.pretendardRegular(size: fs(13)))
                .foregroundStyle(UmpaColor.main)
        }
    }
}

private struct SettingsListItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, fs(12))
    }
}

private struct PrimaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.pretendardRegular(size: fs(13)))
            .foregroundStyle(Color.black)
    }
}

extension View {
    fileprivate func settingsListItem() -> some View {
        self.modifier(SettingsListItemModifier())
    }
}

#Preview {
    @Previewable @State var isOn = false

    VStack {
        BasicSettingsListItem(primaryText: "개인 정보 처리 방침")
        NavigatingSettingsListItem(primaryText: "학력 인증 하기")
        ToggleSettingsListItem(primaryText: "채팅 알림", isOn: $isOn)
        ValueSettingsListItem(primaryText: "앱 버전", valueText: "1.1.0")
    }
    .padding(40)
}
