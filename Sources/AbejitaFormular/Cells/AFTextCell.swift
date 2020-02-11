//
//  File.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 24/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

final class AFTextCell: AFCell {
    var appearance: AFAppearance?
    
    
    
    //MARK: - Outlet
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    //MARK: - Formular Element Attributes
    
    var height: CGFloat {
        let containerWidth = self.formularAppearance.contentFrame.width - self.formularAppearance.contentInsets.horizontalInsets
        let labelHeight = self.textLabel.height(forConstrainedWidth: containerWidth - self.contentAnchors.horizontalInsets)
        return labelHeight + self.contentAnchors.verticalInsets
    }
    
    var formularFrame: CGRect = UIScreen.main.bounds
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    var formularAppearance: AFAppearance = .default
    
    //MARK: - Initializers
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.formularAppearance = appearance
        self.textLabel.text = element.kind.associatedData(as: String.self)
        self.textLabel.font = element.kind.associatedData(as: UIFont.self)
        self.textLabel.textColor = appearance.textColor
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.setLayout()
    }
    
    
    //MARK: - Layout
    
    private var contentAnchors: UIEdgeInsets {
        return self.formularElement?.margin ?? .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.textLabel)
        self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
    }
}



