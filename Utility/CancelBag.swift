//
//  CancelBag.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 04.04.2020.
//  Copyright © 2020 Alexey Naumov. All rights reserved.
//

import Combine

public final class CancelBag {
    fileprivate(set) var subscriptions = [any Cancellable]()

    private let equalToAny: Bool

    public init(equalToAny: Bool = false) {
        self.equalToAny = equalToAny
    }

    public func cancel() {
        subscriptions.removeAll()
    }

//    func isEqual(to other: CancelBag) -> Bool {
//        return other === self || other.equalToAny || equalToAny
//    }
}

extension Cancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.append(self)
    }
}

extension Task: @retroactive Cancellable {}
