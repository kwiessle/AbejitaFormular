//
//  FormularController.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 08/12/2019.
//  Copyright © 2019 Kiefer Wiessler. All rights reserved.
//

import UIKit



open class AFCollectionViewController<F: AbejitaFormular>: UICollectionViewController, AFDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    public var formular = F()
    
    public var completion: (()->())?
        
    
    private var safeElements: [AFElement] {
        return self.formular.elements.filter { $0.condition == true }
    }
    
    
    //MARK: - Initializers
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFormular(withCollectionView: self.collectionView)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.formularShouldEnterEditing ? self.formularFocusFirstResponder() : ()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    private func setupFormular(withCollectionView collectionView: UICollectionView) {
        if let gradient = self.formularAppearance.gradient {
            collectionView.addBackgroundGradient(gradient)
        } else {
            collectionView.backgroundColor = self.formularAppearance.backgroundColor
        }
        collectionView.contentInset = self.formularAppearance.contentInsets
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = self.showScrollIndicator
        collectionView.estimatedItemSizeIfPossible(.desactivate)
        AFTools.registerFormularCells(self.collectionView, for: self.formular.elements)
    }
    
    
    
    
    //MARK: - UIViewController Life Cycle
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.completion?()
    }
    
    
    
    
    //MARK: - Formular Action Delegate
    
    open func formularWillSubmit() {
        //Should be overrided by inherited class
    }
    
    open func formularDidUpdate() {
        //Should be overrided by inherited class
    }
       
    
    
    
    //MARK: - Formular Event Delegate
    
    open func formular(focusNextControlAfter element: AFElement) {
        guard let nextIndex = self.safeElements.indexAfter(element) else {
            self.dismissKeyboard()
            return
        }
        if let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: nextIndex)) as? AFInputableCellDelegate {
            cell.textField.becomeFirstResponder()
        } else if let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: nextIndex)) as? AFSubmitableCellDelegate {
            self.view.endEditing(true)
            cell.button.sendActions(for: .touchUpInside)
        } else {
            self.view.endEditing(true)
        }
    }
    
    open func formularPerformAction(withReuseIdentifer identifier: String, data: Any?) {
        //Should be overrided by inherited class
    }
    
    
    public func reloadFormular() {
        self.collectionView.reloadData()
    }
    
    
    //MARK: - Formular Appearance Delegate
    
    open var formularAppearance: AFAppearance {
        return .default
    }
    
    
    
    
    //MARK: - Formular Data Delegate
    
    open func formular<T>(set value: T, to element: AFElement) {
        guard let wkp = element.keyPath as? WritableKeyPath<F,T> else { return }
        self.formularDidUpdate()
        self.formular[keyPath: wkp] = value
    }
    
    open func formulat<T>(getValueOf element: AFElement, as type: T.Type) -> T? {
        guard let kp = element.keyPath as? KeyPath<F, T> else { return nil }
        return self.formular[keyPath: kp]
    }
    
    public func send(data: Any?, toElementWithReuseIdentifier identifier: String) {
        guard let element = self.formular.getElement(forReuseIdentifier: identifier) else { return }
        guard let index = self.formular.elements.indexOf(element) else { return }
        guard let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: index)) as? AFCollectionViewCell else { return }
        cell.didRecieve(data)
    }

    
    
    //MARK: - Formular Settings Delegate
    
    open var formularShouldEnterEditing: Bool { return false }
             
    open var showScrollIndicator: Bool { return true }
    
    
    
    
    //MARK: - UICollectionView Delegate & DataSource
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
//         let numberOfSection = self.formular.elements.count
        return self.safeElements.count
     }
     
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 1
    }
     
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = self.safeElements[indexPath.section]
        let cell = element.kind.associatedCell.getCell(collectionView, at: indexPath, for: element, delegate: self, withApparence: self.formularAppearance)
        return cell
    }
     
     
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionView.contentInset.horizontalInsets
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! AFCell
        return .init(width: width, height: cell.height)
    }
    
    
    
    
    
    //MARK: - Utils
    
    
    private func formularFocusFirstResponder() {
        for index in 0..<self.safeElements.count {
            let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: index))
            if let inputCell = cell as? AFInputableCellDelegate {
                inputCell.textField.becomeFirstResponder()
                return
            }
        }
    }
    
    
   
}
