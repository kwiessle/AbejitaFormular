//
//  UISwitch+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 31/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

extension UISwitch {

    func set(offTint color: UIColor?) {
        let minSide = min(bounds.size.height, bounds.size.width)
        self.layer.cornerRadius = minSide / 2
        self.backgroundColor = color
        self.tintColor = color
    }
}
