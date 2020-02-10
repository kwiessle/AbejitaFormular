//
//  FormularDefaultSubmitCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

final class AFSubmitCell: AFSubmitableCell {
    var appearance: AFAppearance?
    

    
    
    //MARK: - Outlet
    
    var button: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    //MARK: - Formular Element Attributes
    
    var height: CGFloat { return 90 }
    
    var formularFrame: CGRect = UIScreen.main.bounds
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    
    //MARK: - Inintializers
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularDelegate = delegate
        self.formularElement = element
        self.button.setTitle(element.kind.associatedData(as: String.self), for: .normal)
        self.button.backgroundColor = appearance.tintColor
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.button.addTarget(self, action: #selector(self.buttonDidTapped), for: .touchUpInside)
        self.button.layer.cornerRadius = 10
        self.setLayout()
    }
    
  
    //MARK: - Action
    
    @objc func buttonDidTapped() {
        self.formularDelegate?.formularWillSubmit()
    }
    
    
    //MARK: - Layout
    
    private func setLayout() {
        self.addSubview(self.button)
        
        
        
        self.button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
