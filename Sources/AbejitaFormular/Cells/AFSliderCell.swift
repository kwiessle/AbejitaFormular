//
//  FormularSliderXibCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 31/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

class AFSliderCell: AFXibCell {
    var appearance: AFAppearance?
    
    
    
    @IBOutlet weak var slider: UISlider!
    
    var height: CGFloat { return 80 }
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.slider.tintColor = appearance.tintColor
        self.slider.maximumTrackTintColor = appearance.foregroundColor
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func sliderValueDidChanged() {
        self.formularDelegate?.formular(set: self.slider.value, to: self.formularElement!)
        self.formularDelegate?.formularDidUpdate()
    }
}
