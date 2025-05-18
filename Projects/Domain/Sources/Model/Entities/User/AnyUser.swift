// Created for Umpa in 2025

import Foundation

public struct AnyUser: User {
    private let box: _AbstractUserBox

    init<Base: User>(_ base: Base) {
        box = _UserBox(base)
    }

    public var id: Id { box.id }
    public var userType: UserType { box.userType }
    public var major: Major { box.major }
    public var name: String { box.name }
    public var profileImage: URL? { box.profileImage }
    public var region: Region { box.region }
    public var gender: Gender { box.gender }
}

extension AnyUser {
    public func unwrap<T: User>(as type: T.Type) -> T? {
        if let nestedAnyBox = box as? _UserBox<AnyUser> {
            return nestedAnyBox.base.unwrap(as: type)
        }

        if let concreteBox = box as? _UserBox<T> {
            return concreteBox.base
        }

        return nil
    }
}

private class _AbstractUserBox: User {
    var id: Id { fatalError("Must override") }
    var userType: UserType { fatalError("Must override") }
    var major: Major { fatalError("Must override") }
    var name: String { fatalError("Must override") }
    var profileImage: URL? { fatalError("Must override") }
    var region: Region { fatalError("Must override") }
    var gender: Gender { fatalError("Must override") }

    func hash(into hasher: inout Hasher) {
        fatalError("Must override")
    }

    static func == (lhs: _AbstractUserBox, rhs: _AbstractUserBox) -> Bool {
        fatalError("Must override")
    }
}

private final class _UserBox<Base: User>: _AbstractUserBox {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }

    override var id: Id { base.id }
    override var userType: UserType { base.userType }
    override var major: Major { base.major }
    override var name: String { base.name }
    override var profileImage: URL? { base.profileImage }
    override var region: Region { base.region }
    override var gender: Gender { base.gender }

    override func hash(into hasher: inout Hasher) {
        base.hash(into: &hasher)
    }
}

extension User {
    public func eraseToAnyUser() -> AnyUser {
        AnyUser(self)
    }
}
