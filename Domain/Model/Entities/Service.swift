// Created for Umpa in 2025

import Foundation

public protocol Service: Identifiable, Hashable {
    typealias Id = String

    var id: Id? { get }
    var type: ServiceType { get }
    var title: String { get }
    var thumbnail: URL? { get }
    var rating: Double { get }
    var author: Teacher { get }
    var acceptanceReviews: [AcceptanceReview] { get }
    var reviews: [Review] { get }
    var serviceDescription: String { get }
}

public protocol SinglePriceService: Service {
    var price: Int { get }
}

extension Service {
    public func toAnyService() -> AnyService {
        return AnyService(self)
    }
}

/// 타입 소거(type erasure)를 사용하여 Service 프로토콜을 만족하면서도 Hashable을 제공하는 래퍼 타입.
public struct AnyService: Service {
    // 내부에 캡슐화된 박스
    private let box: _AbstractServiceBox

    /// Service를 준수하는 임의의 인스턴스를 래핑합니다.
    init<S: Service>(_ service: S) {
        self.box = _ServiceBox(service)
    }

    // Service 프로퍼티들 (내부 박스로 전달)
    public var id: String? { box.id }
    public var type: ServiceType { box.type }
    public var title: String { box.title }
    public var thumbnail: URL? { box.thumbnail }
    public var rating: Double { box.rating }
    public var author: Teacher { box.author }
    public var acceptanceReviews: [AcceptanceReview] { box.acceptanceReviews }
    public var reviews: [Review] { box.reviews }
    public var serviceDescription: String { box.serviceDescription }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        box.hash(into: &hasher)
    }

    public static func == (lhs: AnyService, rhs: AnyService) -> Bool {
        return lhs.box.isEqual(to: rhs.box)
    }
}

// MARK: - 내부 박스 정의

/// 내부 추상 클래스로서, 실제 Service 인스턴스에 대한 호출을 추상화합니다.
private class _AbstractServiceBox: Service {
    var id: String? { fatalError("Must override") }
    var type: ServiceType { fatalError("Must override") }
    var title: String { fatalError("Must override") }
    var thumbnail: URL? { fatalError("Must override") }
    var rating: Double { fatalError("Must override") }
    var author: Teacher { fatalError("Must override") }
    var acceptanceReviews: [AcceptanceReview] { fatalError("Must override") }
    var reviews: [Review] { fatalError("Must override") }
    var serviceDescription: String { fatalError("Must override") }

    func hash(into hasher: inout Hasher) {
        fatalError("Must override")
    }

    func isEqual(to other: _AbstractServiceBox) -> Bool {
        fatalError("Must override")
    }

    static func == (lhs: _AbstractServiceBox, rhs: _AbstractServiceBox) -> Bool {
        fatalError("Must override")
    }
}

/// _AnyServiceBase를 상속받아 실제 Service 인스턴스를 저장하는 박스입니다.
private final class _ServiceBox<Base: Service>: _AbstractServiceBox {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }

    override var id: String? { base.id }
    override var type: ServiceType { base.type }
    override var title: String { base.title }
    override var thumbnail: URL? { base.thumbnail }
    override var rating: Double { base.rating }
    override var author: Teacher { base.author }
    override var acceptanceReviews: [AcceptanceReview] { base.acceptanceReviews }
    override var reviews: [Review] { base.reviews }
    override var serviceDescription: String { base.serviceDescription }

    override func hash(into hasher: inout Hasher) {
        base.hash(into: &hasher)
    }

    /// 두 박스의 내용이 같은지 비교합니다.
    override func isEqual(to other: _AbstractServiceBox) -> Bool {
        // 동일한 Base 타입일 때만 비교하고, 그렇지 않으면 false 반환
        if let otherBox = other as? _ServiceBox<Base> {
            return base == otherBox.base
        }
        return false
    }
}
