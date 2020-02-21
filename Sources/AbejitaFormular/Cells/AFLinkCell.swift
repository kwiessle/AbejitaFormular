//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 05/02/2020.
//

import UIKit

class AFLinkCell: AFCell {
    
    
    var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Link", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.numberOfLines = 0
        
        return button
    }()
    
    
    var height: CGFloat {
        let formularAppearance = self.appearance ?? .default
        let containerWidth = formularAppearance.contentFrame.width - formularAppearance.contentInsets.horizontalInsets
        let buttonHeight = self.linkButton.height(forConstrainedWidth: containerWidth - self.contentAnchors.horizontalInsets)
        return buttonHeight + self.contentAnchors.verticalInsets
    }
    
    var formularElement: AFElement?
    
    var formularDelegate: AFDelegate?
    
    var appearance: AFAppearance?
    
    
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
        self.formularElement = element
        self.formularDelegate = delegate
        self.appearance = appearance
        
        let string = element.kind.associatedData(as: String.self) ?? "Link"
        let font = element.kind.associatedData(as: UIFont.self)
    
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: appearance.textColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        self.linkButton.setAttributedTitle(
            NSMutableAttributedString(
                string: string,
                attributes: attributes
            ),
            for: .normal
        )
        
        
        self.defaultSetup()
        
    }
    
    @objc func linkButtonDidTapped() {
        if let identifier = self.formularElement?.reuseIdentifier {
            self.formularDelegate?.formularPerformAction(withReuseIdentifer: identifier, data: nil)
        }
    }
    
    private func defaultSetup() {
        self.linkButton.addTarget(self, action: #selector(self.linkButtonDidTapped), for: .touchUpInside)
        self.setLayout()
    }
    
    private var contentAnchors: UIEdgeInsets {
        return self.formularElement?.margin ?? .init(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    private func setLayout() {
        self.addSubview(self.linkButton)
        
        self.linkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentAnchors.top).isActive = true
        self.linkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentAnchors.left).isActive = true
        self.linkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.contentAnchors.right).isActive = true
        self.linkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentAnchors.bottom).isActive = true
        
    }
    
    
    
    
}
