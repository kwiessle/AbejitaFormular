//
//  UILabel+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 26/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func height(forConstrainedWidth width: CGFloat) -> CGFloat {
        guard let text = self.text else { return 0 }
        return text.height(withConstrainedWidth: width, font: self.font)
    }
    
}
