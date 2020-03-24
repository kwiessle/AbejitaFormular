//
//  Formular.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 09/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

//MARK: - Formular

public protocol AbejitaFormular {
    // - Properties

    var title: String { get set }
    var elements: [AFElement] { get }
    // - Default Constructor

    init()
}

public extension AbejitaFormular {
    
    
    func indexOf(_ element: AFElement) -> Int? {
        return self.elements.firstIndex(of: element)
    }
    
    func indexAfter(_ element: AFElement) -> Int? {
        guard let index = self.indexOf(element) else { return nil }
        let nextIndex = index + 1
        return nextIndex < self.elements.count ? nextIndex : nil
    }
    
    func indexBefore(_ element: AFElement) -> Int? {
        guard let index = self.indexOf(element) else { return nil }
        let previousIndex = index - 1
        return previousIndex >= 0 ? previousIndex : nil
    }
    
    var isValid: Bool {
        return true
    }
    
   
    
}
