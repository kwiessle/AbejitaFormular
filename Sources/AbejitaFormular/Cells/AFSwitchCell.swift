//
//  FromularDefaultSwitchCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 26/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

class AFSwitchCell: AFCell {
    
    
    var appearance: AFAppearance?
    
    lazy var checker: UISwitch = {
        let checker = UISwitch()
        checker.translatesAutoresizingMaskIntoConstraints = false
        checker.addTarget(self, action: #selector(self.checkerValueDidChange), for: .valueChanged)
        return checker
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var height: CGFloat {
        let insets = self.contentAnchors.horizontalInsets + self.contentAnchors.left + self.checker.frame.width
        let constainerWidth = self.formularAppearance.contentFrame.width - self.formularAppearance.contentInsets.horizontalInsets
        return self.textLabel.height(forConstrainedWidth: constainerWidth - insets) + self.contentAnchors.verticalInsets
    }
    
    var formularFrame: CGRect = UIScreen.main.bounds
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    var formularAppearance: AFAppearance = .default
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularDelegate = delegate
        self.formularElement = element
        self.formularAppearance = appearance
        self.textLabel.text = element.kind.associatedData(as: String.self)
        let value = delegate?.formulat(getValueOf: element, as: Bool.self) ?? false
        self.checker.setOn(value, animated: false)
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.formularDelegate?.formular(set: self.checker.isOn, to: self.formularElement!)
        self.setLayout()
    }
    
    private var contentAnchors: UIEdgeInsets {
        return .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.checker)
        self.addSubview(self.textLabel)
        
        self.textLabel.textColor = self.formularAppearance.textColor
        self.checker.onTintColor = self.formularAppearance.tintColor
        self.checker.set(offTint:  self.formularAppearance.foregroundColor)
        
        self.checker.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.checker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.textLabel.topAnchor.constraint(equalTo: self.checker.topAnchor).isActive = true
        self.checker.trailingAnchor.constraint(equalTo: self.textLabel.leadingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
    }
    
    @objc private func checkerValueDidChange() {
        print("value changed to \(self.checker.isOn)")
        self.formularDelegate?.formular(set: self.checker.isOn, to: self.formularElement!)
        self.formularDelegate?.formularDidUpdate()
    }
    
    
}
