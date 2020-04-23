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
    var isValid: Bool {
        return true
    }
}


