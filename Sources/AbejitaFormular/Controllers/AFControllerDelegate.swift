//
//  FormularController+Protocols.swift
//  ZDFormular
//
//  Created by Kiefer Wiessler on 02/02/2020.
//  Copyright © 2020 Kiefer Wiessler. All rights reserved.
//

import Foundation

public typealias AFDelegate = AFEventDelegate &
                              AFActionDelegate &
                              AFAppearanceDelegate &
                              AFDataDelegate &
                              AFSettingsDelegate


public protocol AFDataDelegate {
    func formular<T>(set value: T, to element: AFElement)
    func formulat<T>(getValueOf element: AFElement, as type: T.Type) -> T?
}


public protocol AFEventDelegate {
    func formular(focusNextControlAfter element: AFElement)
}


public protocol AFSettingsDelegate {
    var formularShouldEnterEditing: Bool { get }
    var showScrollIndicator: Bool { get }
}


public protocol AFAppearanceDelegate {
    var formularAppearance: AFAppearance { get }
}


public protocol AFActionDelegate {
    func formularWillSubmit()
    func formularDidUpdate()
}
