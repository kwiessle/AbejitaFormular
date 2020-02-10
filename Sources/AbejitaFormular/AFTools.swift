//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 09/02/2020.
//

import UIKit


class AFTools {
    
    static func registerFormularCells(_ collectionView: UICollectionView, for elements: [AFElement]) {
           elements.forEach { element in
               let cell = element.kind.associatedCell.self
               if let xibCell = cell as? AFXibCell.Type {
                   collectionView.register(xibCell)
               } else {
                   collectionView.register(cell)
               }
           }
       }
    
    
}
