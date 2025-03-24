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

    public init() {}

    public func cancel() {
        subscriptions.removeAll()
    }
}

extension Cancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.append(self)
    }
}

extension Task: @retroactive Cancellable {}
