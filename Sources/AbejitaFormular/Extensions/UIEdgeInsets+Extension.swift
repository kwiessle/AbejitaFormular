//
//  UIEdgeInset+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 26/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    
    var horizontalInsets: CGFloat {
        return self.left + self.right
    }
    
    var verticalInsets: CGFloat {
        return self.top + self.bottom
    }
}
