// Created for Umpa in 2025

import Combine
import Foundation
import SwiftUI
import Testing

extension Tag {
    @Tag static var interactor: Tag
    @Tag static var domain: Tag
}

struct BindingWithPublisher<Value> {
    let binding: Binding<Value>
    let updatesRecorder: AnyPublisher<[Value], Never>

    init(_ value: Value, recordingTimeInterval: TimeInterval = 0.5) {
        var value = value
        var updates = [value]
        binding = Binding<Value>(
            get: { value },
            set: { value = $0; updates.append($0) })
        updatesRecorder = Future<[Value], Never> { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + recordingTimeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher()
    }
}
