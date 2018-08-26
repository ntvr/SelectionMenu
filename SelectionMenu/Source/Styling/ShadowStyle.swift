//
//  ShadowStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

struct ShadowStyle {
    let shadowColor: CGColor?
    let shadowOpacity: Float
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
}

// MARK: - SelectionElementStyling
extension ShadowStyle: SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool) {
        element.layer.shadowColor = shadowColor
        element.layer.shadowOpacity = shadowOpacity
        element.layer.shadowOffset = shadowOffset
        element.layer.shadowRadius = shadowRadius
    }
}

// MARK: - SelectionCollectionStyling
extension ShadowStyle: SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView) {
        collection.layer.shadowColor = shadowColor
        collection.layer.shadowOpacity = shadowOpacity
        collection.layer.shadowOffset = shadowOffset
        collection.layer.shadowRadius = shadowRadius
    }
}

extension ShadowStyle {
    static var light = ShadowStyle(
        shadowColor: UIColor.lightGray.cgColor,
        shadowOpacity: 0.5,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)

    static var medium = ShadowStyle(
        shadowColor: UIColor.gray.cgColor,
        shadowOpacity: 0.6,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)

    static var dark = ShadowStyle(
        shadowColor: UIColor.darkGray.cgColor,
        shadowOpacity: 1.0,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)
}
