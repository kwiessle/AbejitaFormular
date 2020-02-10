//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 10/02/2020.
//

import UIKit


extension UIButton {
    func height(forConstrainedWidth width: CGFloat) -> CGFloat {
        guard let text = self.titleLabel?.text, let font = self.titleLabel?.font else { return 0 }
        return text.height(withConstrainedWidth: width, font: font)
    }
}
