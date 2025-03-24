// Created for Umpa in 2025

import SwiftUI

public struct CheckBox: View {
    public struct Attributes {
        let backgroundColor: Color
        let foregroundColor: Color
        let checkmarkColor: Color
        let strokeColor: Color
        let strokeWidth: CGFloat
        let cornerRadius: CGFloat

        public init(
            backgroundColor: Color,
            foregroundColor: Color,
            checkmarkColor: Color,
            strokeColor: Color,
            strokeWidth: CGFloat,
            cornerRadius: CGFloat
        ) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.checkmarkColor = checkmarkColor
            self.strokeColor = strokeColor
            self.strokeWidth = strokeWidth
            self.cornerRadius = cornerRadius
        }

        static func defaultBy(_ dimension: CGFloat) -> Attributes {
            Attributes(
                backgroundColor: .white,
                foregroundColor: .blue,
                checkmarkColor: .white,
                strokeColor: .gray,
                strokeWidth: dimension / 11.0,
                cornerRadius: dimension / 6.0
            )
        }
    }

    @Binding var isOn: Bool

    @State private var isPressing = false

    let dimension: CGFloat

    let attributes: Attributes

    public init(
        isOn: Binding<Bool>,
        dimension: CGFloat = 24,
        attributes: Attributes? = nil
    ) {
        self._isOn = isOn
        self.dimension = dimension
        self.attributes = attributes ?? .defaultBy(dimension)
    }

    public var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: attributes.cornerRadius)
                    .strokeBorder(
                        (isPressing && isOn) ? Color.clear : attributes.strokeColor,
                        style: StrokeStyle(lineWidth: attributes.strokeWidth)
                    )
                    .background(
                        attributes.backgroundColor,
                        in: RoundedRectangle(cornerRadius: attributes.cornerRadius)
                    )
                    // To hide the backgroundColor that is sticking out of the rounded rectangle.
                    // Not sure, but this is maybe a issue from rendering.
                    .padding(0.6)
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .fontWeight(.semibold)
                    .foregroundStyle(attributes.checkmarkColor)
                    .opacity(isOn ? 1 : 0)
                    .padding(dimension / 4.5)
                    .background(
                        isOn ? attributes.foregroundColor : Color.clear,
                        in: RoundedRectangle(cornerRadius: attributes.cornerRadius)
                    )
            }
            .frame(width: dimension, height: dimension)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isPressing = true
                    }
                    .onEnded { _ in
                        isPressing = false
                    }
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var isOn1 = true
    @Previewable @State var isOn2 = true
    @Previewable @State var isOn3 = true
    @Previewable @State var isOn4 = true
    @Previewable @State var isOn5 = true

    // 1.
    CheckBox(
        isOn: $isOn1,
        dimension: 20
    )
    .padding()

    // 2.
    CheckBox(
        isOn: $isOn2,
        dimension: 50,
        attributes: CheckBox.Attributes(
            backgroundColor: .black,
            foregroundColor: .blue,
            checkmarkColor: .black,
            strokeColor: .gray,
            strokeWidth: 6,
            cornerRadius: 10
        )
    )
    .padding()
    .background(Color.black)

    // 3.
    CheckBox(
        isOn: $isOn3,
        dimension: 80
    )
    .padding()

    // 4.
    CheckBox(
        isOn: $isOn4,
        dimension: 120,
        attributes: CheckBox.Attributes(
            backgroundColor: .black,
            foregroundColor: .blue,
            checkmarkColor: .black,
            strokeColor: .gray,
            strokeWidth: 6,
            cornerRadius: 10
        )
    )
    .padding()

    // 4.
    CheckBox(isOn: $isOn5)
        .padding()
}
