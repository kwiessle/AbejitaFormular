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
    
//    static public var Pinky: AFAppearance { return .init(
//        backgroundColor: .systemPink,
//        textColor: .white,
//        tintColor: .systemTeal,
//        contentInsets: .init(top: 50, left: 15, bottom: 0, right: 15),
//        gradient: .init(start: .topCenter, end: .bottomCenter, colors: [UIColor.systemPink.cgColor, UIColor.systemIndigo.cgColor], type: .axial)
//    ) }
//
//    static public var Bluewy: AFAppearance { return .init(
//        backgroundColor: .systemIndigo,
//        textColor: .white,
//        tintColor: .systemIndigo,
//        contentInsets: .init(top: 50, left: 15, bottom: 0, right: 15),
//        gradient: .init(start: .topCenter, end: .bottomCenter, colors: [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor], type: .axial)
//    ) }
    
}
