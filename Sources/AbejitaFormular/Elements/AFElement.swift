//
//  FormularElement.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


open class AFElement: Equatable {
    
    public let kind: AFElementKind
    public let keyPath: AnyKeyPath?
    public var reuseIdentifier: String?
    public var margin: UIEdgeInsets?
    
    var condition: Bool = true
    
    public init (kind: AFElementKind, _ keyPath: AnyKeyPath? = nil) {
        self.kind = kind
        self.keyPath = keyPath
    }
    
    public init (kind: AFDefaultElementKind, _ keyPath: AnyKeyPath? = nil) {
        self.kind = kind
        self.keyPath = keyPath
    }
    
    public static func == (lhs: AFElement, rhs: AFElement) -> Bool {
        return lhs.kind.rawDescription == rhs.kind.rawDescription &&
            lhs.keyPath == rhs.keyPath
    }
    
    public func margin(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> AFElement {
        self.margin = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    public func registerIdentifer(_ reuseIdentifier: String) -> AFElement {
        self.reuseIdentifier = reuseIdentifier
        return self
    }
    
    public func `if`(_ condition: Bool) -> AFElement {
        self.condition = condition
        return self
    }
    
}

public extension Array where Element == AFElement {
    func indexOf(_ element: AFElement) -> Int? {
        return self.firstIndex(of: element)
    }
    
    func indexAfter(_ element: AFElement) -> Int? {
        guard let index = self.indexOf(element) else { return nil }
        let nextIndex = index + 1
        return nextIndex < self.count ? nextIndex : nil
    }

    func indexBefore(_ element: AFElement) -> Int? {
        guard let index = self.indexOf(element) else { return nil }
        let previousIndex = index - 1
        return previousIndex >= 0 ? previousIndex : nil
    }
}
