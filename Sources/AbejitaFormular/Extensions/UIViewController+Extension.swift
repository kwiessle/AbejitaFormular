//
//  UIViewController+Extension.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/01/2020.
//  Copyright © 2020 Kiefer Wiessler. All rights reserved.
//

import UIKit


extension UIViewController {
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
