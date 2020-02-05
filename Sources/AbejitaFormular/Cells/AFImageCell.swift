//
//  FormularDefaultImageCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 27/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


class AFImageCell: AFCell {
    var appearance: AFAppearance?
    
    
    //MARK: - Outlet
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Formular Element Attribbutes
    
    var height: CGFloat { return self.customHeight ?? 200 }
    
    private var customHeight: CGFloat?
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    
    //MARK: - Initializers
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.imageView.image = element.kind.associatedData(as: UIImage.self)
        self.customHeight = element.kind.associatedData(as: CGFloat.self)
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.setLayout()
    }
    
    private var contentAnchors: UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.imageView)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
        
    }
    
    
}
