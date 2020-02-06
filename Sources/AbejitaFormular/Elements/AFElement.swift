//
//  FormularElement.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


public class AFElement: Equatable {
    
    public let kind: AFElementKind
    public let keyPath: AnyKeyPath?
    internal var reuseIdentifier: String?
    
    var margin: UIEdgeInsets?
    
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
}
