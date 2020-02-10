//
//  FormularCell.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit



public typealias AnyAFCell = UICollectionViewCell & AFCellAttributes

public typealias AFCell =  AnyAFCell

public typealias AFXibCell = AnyAFCell & NibRegistrableCell

public typealias AFInputableCell = AnyAFCell & AFInputableCellDelegate & UITextFieldDelegate

public typealias AFSubmitableCell = AnyAFCell & AFSubmitableCellDelegate



public enum AFInputType {
    case text
    case password
    case email
    case number
    case phoneNumber
}



public protocol AFInputableCellDelegate  {
    var textField: UITextField! { get }
}

public extension AFInputableCellDelegate {
    func setupTextField(for type: AFInputType) {
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
    
}

public protocol AFSubmitableCellDelegate {
    var button: UIButton! { get }
}



public protocol NibRegistrableCell {}

public extension NibRegistrableCell {
    
    static var nibName: String { return String(describing: Self.self) }
    
    static var nib: UINib { return UINib(nibName: self.nibName, bundle: Bundle(for: Self.self as! AnyClass)) }
    
    static func instanciateFromNib() -> Self {
        return self.nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
}



public protocol AFCellAttributes: AnyObject {
    var height: CGFloat { get }
    var formularElement: AFElement? { get set }
    var formularDelegate: AFDelegate? { get set }
    var appearance: AFAppearance? { get set }
    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance)
}



public extension AFCellAttributes {

    static var identifier: String { return "\(String(describing: Self.self))" }
    
//    func setup(element: AFElement, delegate: AFDelegate?, _ appearance: AFAppearance) {
//        self.formularElement = element
//        self.formularDelegate = delegate
//        self.appearance = appearance
//    }
    
    static func getCell(_ collectionView: UICollectionView, at indexPath: IndexPath, for element: AFElement, delegate: AFDelegate?, withApparence appearance: AFAppearance) -> AFCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.identifier, for: indexPath) as! AFCell
        cell.setup(element: element, delegate: delegate, appearance)
        return cell
    }
    
}









