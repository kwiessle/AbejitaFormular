//
//  UICollectionView+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 09/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

public extension UICollectionView {
 
    func register(_ formularCell: AFCell.Type) {
        self.register(formularCell, forCellWithReuseIdentifier: formularCell.xibIdentifier)
    }
    
    func register(_ AFXibCell: AFXibCell.Type) {
        self.register(AFXibCell.nib, forCellWithReuseIdentifier: AFXibCell.xibIdentifier)
    }
    
    func dequeueCell<C: AFCell>(as formularCell: C.Type, at indexPath: IndexPath) -> C {
        return self.dequeueReusableCell(withReuseIdentifier: C.xibIdentifier, for: indexPath) as! C
    }
    
    func getFormularCell<C: AFCell>(at index: Int, as type: C.Type) -> C? {
        return self.cellForItem(at: IndexPath(item: 0, section: index)) as? C
    }
    
   func addBackgroundGradient(_ gradient: CAGradientLayer) {
        let collectionViewBackgroundView = UIView()
        gradient.frame.size = self.frame.size
        self.backgroundView = collectionViewBackgroundView
        self.backgroundView?.layer.addSublayer(gradient)
   }
}

