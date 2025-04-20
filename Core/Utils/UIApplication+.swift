// Created for Umpa in 2025

import UIKit

extension UIApplication {
    /// KeyWindow 의 `rootViewController`를 반환
    public var keyRootViewController: UIViewController? {
        return self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
