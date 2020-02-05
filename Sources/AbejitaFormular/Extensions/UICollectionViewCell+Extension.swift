//
//  UICollectionViewCell+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 22/01/2020.
//  Copyright © 2020 Kiefer Wiessler. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    open override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.frame.size
    }
}
