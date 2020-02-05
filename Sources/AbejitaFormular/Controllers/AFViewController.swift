//
//  FormularViewController.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 02/02/2020.
//  Copyright © 2020 Kiefer Wiessler. All rights reserved.
//

import UIKit

open class AFViewController<F: AbejitaFormular>: UIViewController, AFDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties

    private var collectionView: UICollectionView!
    
    public var formular = F()
    
  
    
    
    //MARK: - Initializers
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.formularShouldEnterEditing ? self.formularFocusFirstResponder() : ()
    }
    
    public func setupFormular(withCollectionView collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let gradient = self.formularAppearance.gradient {
            self.collectionView.addBackgroundGradient(gradient)
        } else {
            self.collectionView.backgroundColor = self.formularAppearance.backgroundColor
        }
        self.collectionView.contentInset = self.formularAppearance.contentInsets
        self.collectionView.delegate = self
        self.collectionView.showsVerticalScrollIndicator = self.showScrollIndicator
        self.registerFormularCells(self.collectionView, for: self.formular.elements)
    }
       
    
    
    
    //MARK: - Formular Event Delegate
    
    open func formular(focusNextControlAfter element: AFElement) {
        guard let nextIndex = self.formular.indexAfter(element) else {
            self.dismissKeyboard()
            return
        }
        if let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: nextIndex)) as? AFInputableCell {
            cell.textField.becomeFirstResponder()
        } else if let cell = self.collectionView?.cellForItem(at: IndexPath(item: 0, section: nextIndex)) as? AFSubmitableCell {
            self.view.endEditing(true)
            cell.submitButton.sendActions(for: .touchUpInside)
        } else {
            self.view.endEditing(true)
        }
    }
    
    
    
    //MARK: - Formular Action Delegate
    
    open func formularWillSubmit() {
        //Should be overrided by inherited class
    }
    
    open func formularDidUpdate() {
        print(self.formular)
        //should be overrided by inherited class
    }
    
    
    
    //MARK: - Formular Appearance Delegate
    
    open var formularAppearance: AFAppearance {
        return .default
    }
    
    
    
    
    //MARK: - Formular Data Delegate
    
    open func formular<T>(set value: T, to element: AFElement) {
        guard let wkp = element.keyPath as? WritableKeyPath<F,T> else { return }
        self.formular[keyPath: wkp] = value
    }
    
    open func formulat<T>(getValueOf element: AFElement, as type: T.Type) -> T? {
        guard let kp = element.keyPath as? KeyPath<F, T> else { return nil }
        return self.formular[keyPath: kp]
    }
    
    
   
    
    //MARK: - Formular Settings Delegate
    
    open var showScrollIndicator: Bool { return true }
    
    open var formularShouldEnterEditing: Bool { return false }
     
    
    
    
    //MARK: - UICOllectionView Delegate & DataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection = self.formular.elements.count
        return numberOfSection
    }
     
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
     
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = self.formular.elements[indexPath.section]
        let cell = element.kind.associatedCell.getCell(collectionView, at: indexPath, for: element, delegate: self, withApparence: self.formularAppearance)
        return cell
    }
     
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionView.contentInset.horizontalInsets
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! AFCell
        return .init(width: width, height: cell.height)
    }
    
    
    
    
    //MARK: - Utils
    
    public func formularFocusFirstResponder() {
        for index in 0..<self.formular.elements.count {
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: 0, section: index))
            if let inputCell = cell as? AFInputableCell {
                inputCell.textField.becomeFirstResponder()
                return
            }
        }
    }
    
    private func registerFormularCells(_ collectionView: UICollectionView?, for elements: [AFElement]) {
        elements.forEach { element in
            let cell = element.kind.associatedCell.self
            if let xibCell = cell as? AFXibCell.Type {
                collectionView?.register(xibCell)
            } else {
                collectionView?.register(cell)
            }
        }
    }
    
}
