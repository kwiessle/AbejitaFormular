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
    
    var submitButton: UIButton! = {
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
        self.submitButton.setTitle(element.kind.associatedData(as: String.self), for: .normal)
        self.submitButton.backgroundColor = appearance.tintColor
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.submitButton.addTarget(self, action: #selector(self.submitButtonDidTapped), for: .touchUpInside)
        self.submitButton.layer.cornerRadius = 10
        self.setLayout()
    }
    
  
    //MARK: - Action
    
    @objc func submitButtonDidTapped() {
        self.formularDelegate?.formularWillSubmit()
    }
    
    
    //MARK: - Layout
    
    private func setLayout() {
        self.addSubview(self.submitButton)
        
        
        
        self.submitButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        self.submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
