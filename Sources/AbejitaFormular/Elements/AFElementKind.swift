//
//  FormularElementKind.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 23/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit


// MARK: - Formular Element Kind Protocol

public protocol AFElementKind {
    var associatedCell: AnyAFCell.Type { get }
    func associatedData<T>(as type: T.Type) -> T?
    
}

public extension AFElementKind {
    var rawDescription: String { return String(describing: Self.self) }
}

// MARK: - Default Formular Elements Kinds

public enum AFDefaultElementKind: AFElementKind {
    
    // - Elements cases
    case header(title: String, alignment: NSTextAlignment, font: UIFont? = UIFont.systemFont(ofSize: 60, weight: .bold))
    case input(placeholder: String, type: AFInputType)
    case text(_ value: String, font: UIFont? = UIFont.systemFont(ofSize: 17))
    case checkBox(text: String)
    case submit(title: String)
    case image(_ image: UIImage?, height: CGFloat? = nil)
    case slider
    
    
    // - Associated UICollectionViewCell
    public var associatedCell: AnyAFCell.Type {
        switch self {
            case .header:       return AFHeaderCell.self
            case .input:        return AFInputCell.self
            case .text:         return AFTextCell.self
            case .checkBox:     return AFSwitchCell.self
            case .submit:       return AFSubmitCell.self
            case .image:        return AFImageCell.self
            case .slider:       return AFSliderCell.self
        }
    }
    
    // - Associated data for given type
    public func associatedData<T>(as type: T.Type) -> T? {
        switch self {
            
            case .header(let title, let alignment, let font):
                if let ttl = title as? T { return ttl }
                else if let algnmt = alignment as? T { return algnmt }
                else if let fnt = font as? T { return fnt }
                else { return nil }
            
            case .input(let placeHolder, let type):
                if let ph = placeHolder as? T { return ph }
                else if let t = type as? T { return t }
                else { return nil }

            case .text(let text, let font):
                if let txt = text as? T { return txt }
                else if let fnt = font as? T { return fnt }
                else { return nil }
            
            case .checkBox(let text):
                return text as? T
            
            case .submit(let title):
                return title as? T
            
            case .image(let image, let height):
                if let img = image as? T { return img }
                else if let h = height as? T { return h }
                else { return nil }
            
            default: return nil
        }
    }
    
    
}
