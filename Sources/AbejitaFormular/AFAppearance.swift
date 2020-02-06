//
//  FormularApparence.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 24/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


public struct AFAppearance {
    var backgroundColor: UIColor
    var textColor: UIColor
    var tintColor: UIColor
    var contentFrame: CGRect = UIScreen.main.bounds
    var contentInsets: UIEdgeInsets
    var gradient: CAGradientLayer?
    var foregroundColor: UIColor = UIColor(white: 0, alpha: 0.3)
    
    public init (backgroundColor: UIColor, textColor: UIColor, tintColor: UIColor, contentInsets: UIEdgeInsets = .zero, gradient: CAGradientLayer? = nil) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.tintColor = tintColor
        self.contentInsets = contentInsets
        self.gradient = gradient
    }
}



extension AFAppearance {
    
    static public var `default`: AFAppearance { return .init(
        backgroundColor: .white,
        textColor: .gray,
        tintColor: .blue
    )}
    
}
