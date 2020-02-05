//
//  FormularDefaultTitleCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


final class AFHeaderCell: AFCell {
    var appearance: AFAppearance?
    

    //MARK: - Outlet
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Formular Element Attributes
    
    var height: CGFloat {
        let containerWidth = self.formularAppearance.contentFrame.width - self.formularAppearance.contentInsets.horizontalInsets
        let labelHeight = self.titleLabel.height(forConstrainedWidth: containerWidth - self.contentAnchors.horizontalInsets)
        return labelHeight + self.contentAnchors.verticalInsets
    }
    
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    var formularAppearance: AFAppearance!
    
    
    //MARK: - Initializers
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.formularAppearance = appearance
        self.titleLabel.text = element.kind.associatedData(as: String.self)
        self.titleLabel.textAlignment = element.kind.associatedData(as: NSTextAlignment.self) ?? .left
        self.titleLabel.font = element.kind.associatedData(as: UIFont.self)
        self.titleLabel.textColor = appearance.textColor
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.setLayout()
    }
    
    
    //MARK: - Layout
    
    private var contentAnchors: UIEdgeInsets {
        return .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
    }
}
