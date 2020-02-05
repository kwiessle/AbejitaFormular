//
//  FormularTextFieldCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 09/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit

final class AFInputCell: AFInputableCell {
    var appearance: AFAppearance?
    
    
   
    //MARK: - Outlet
    
    var textField: UITextField! = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.textColor = .white
        return textField
    }()
    
    
    //MARK: - Formular Element Attributes
    
    var height: CGFloat {
        self.contentAnchors.verticalInsets + 45
    }
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    
    //MARK: - Initializers
    
    public func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.textField.delegate = self
        self.textField.attributedPlaceholder = NSMutableAttributedString(
            string: element.kind.associatedData(as: String.self) ?? "",
            attributes: [.foregroundColor: appearance.textColor]
        )
        self.textField.backgroundColor = appearance.foregroundColor
        self.defaultSetup()
        self.setupToolBar()
    }
    
    private func defaultSetup() {
        self.textField.addTarget(self, action: #selector(self.textValueDidChange), for: .editingChanged)
        if let type = self.formularElement?.kind.associatedData(as: AFInputType.self) {
            self.setupTextField(for: type)
        }
        self.setLayout()
    }
    
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneBarButtonDidTapped))
        toolBar.setItems([doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
    }
    
    
    @objc func doneBarButtonDidTapped() {
        self.textField.resignFirstResponder()
    }
    
    private func setupTextField(for type: AFInputType) {
        switch type {
            case .email:
                self.textField.keyboardType = .emailAddress
                self.textField.isSecureTextEntry = false
            case .password:
                self.textField.keyboardType = .default
                self.textField.isSecureTextEntry = true
            case .number:
                self.textField.keyboardType = .numberPad
                self.textField.isSecureTextEntry = false
            case .text:
                self.textField.keyboardType = .default
                self.textField.isSecureTextEntry = false
            case .phoneNumber:
                self.textField.keyboardType = .phonePad
                self.textField.isSecureTextEntry = false
        }
    }
    
    
    //MARK: - Action
    
    @objc private func textValueDidChange() {
        self.formularDelegate?.formular(set: self.textField.text!, to: self.formularElement!)
        self.formularDelegate?.formularDidUpdate()
    }
    
    
    
    //MARK: - Layout
    
    private var contentAnchors: UIEdgeInsets {
        return self.formularElement?.margin ?? .init(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.textField)
        self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: 15, height: 20))
        self.textField.leftView = paddingView
        self.textField.leftViewMode = .always
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = self.formularDelegate?.formular(focusNextControlAfter: self.formularElement!)
        return true
    }
    
}
