//
//  NetworkMonitor.swift
//  Utility
//
//  Created by Jaewon Yun on 2023/11/13.
//  Copyright © 2023 woin2ee. All rights reserved.
//

import Combine
import Foundation
import Network

/// 인터넷 연결 상태를 모니터링하는 객체입니다.
///
/// 모니터링을 시작하기 위해서 `start()` 함수를 호출해야 합니다.
public final class NetworkMonitor {
    public static let shared = NetworkMonitor()

    let queue: DispatchQueue
    let monitor = NWPathMonitor()

    @Published public private(set) var isEstablishedConnection: Bool = false

    private init() {
        self.queue = DispatchQueue(label: "com.pob.umpa.network_monitor", qos: .utility)

        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            if path.status == .satisfied {
                self.isEstablishedConnection = true
            } else {
                self.isEstablishedConnection = false
            }
        }

        monitor.start(queue: queue)
    }

    public static func start() {
        _ = NetworkMonitor.shared
    }
}
