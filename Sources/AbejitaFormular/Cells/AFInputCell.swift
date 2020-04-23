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
        textField.layer.cornerRadius = 10
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
        self.textField.clearButtonMode = .always
        self.setLayout()
        self.setupToolBar()
        self.defaultSetup()
    }
    
    private func defaultSetup() {
        self.textField.addTarget(self, action: #selector(self.textValueDidChange), for: .editingChanged)
        if let type = self.formularElement?.kind.associatedData(as: AFInputType.self) {
            self.setupTextField(for: type)
        }
    }
    
    
    private func setupToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneBarButtonDidTapped))
        doneButton.tintColor = UIColor(red:0.23, green:0.47, blue:0.95, alpha:1.0)
        doneButton.style = .plain
        toolBar.setItems([doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
    }

    
    @objc func doneBarButtonDidTapped() {
        self.textField.resignFirstResponder()
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
        self.contentView.addSubview(self.textField)
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: self.contentAnchors.left),
            self.textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -self.contentAnchors.right),
            self.textField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.contentAnchors.top),
            self.textField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -self.contentAnchors.bottom)
        ])
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: 15, height: 20))
        self.textField.leftView = paddingView
        self.textField.leftViewMode = .always
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text != "" {
            self.formularDelegate?.formular(focusNextControlAfter: self.formularElement!)
        }
        return true
    }
    
}
