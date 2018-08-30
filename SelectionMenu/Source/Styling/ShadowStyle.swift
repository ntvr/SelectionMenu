//
//  ShadowStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Can be used to apply style of the shadow to either SelectionCollection or SelectionElement.
public struct ShadowStyle {

    /// Color of the shadow - mapped directly to layer.
    public let shadowColor: CGColor?
    /// Oppacity of the shadow - mapped directly to layer.
    public let shadowOpacity: Float

    /// Offset of the shadow - mapped directly to layer.
    public let shadowOffset: CGSize

    /// Radius of the shadow - mapped directly to layer.
    public let shadowRadius: CGFloat

    /// Initializes ShadowStyle with given values.
    ///
    /// - Parameter shadowColor: Color of the shadow - mapped directly to layer.
    /// - Parameter shadowOpacity: Oppacity of the shadow - mapped directly to layer.
    /// - Parameter shadowOffset: Offset of the shadow - mapped directly to layer.
    /// - Parameter shadowRadius: Radius of the shadow - mapped directly to layer.
    public init(
        shadowColor: CGColor?,
        shadowOpacity: Float,
        shadowOffset: CGSize,
        shadowRadius: CGFloat)
    {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }
}

// MARK: - SelectionElementStyling
extension ShadowStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, selected: Bool) {
        element.layer.shadowColor = shadowColor
        element.layer.shadowOpacity = shadowOpacity
        element.layer.shadowOffset = shadowOffset
        element.layer.shadowRadius = shadowRadius
    }
}

// MARK: - SelectionCollectionStyling
extension ShadowStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {
        collection.layer.shadowColor = shadowColor
        collection.layer.shadowOpacity = shadowOpacity
        collection.layer.shadowOffset = shadowOffset
        collection.layer.shadowRadius = shadowRadius
    }
}

public extension ShadowStyle {

    /// Light shadow style with:
    /// - shadowColor: UIColor.lightGray,
    /// - shadowOpacity: 0.5,
    /// - shadowOffset: CGSize(width: 0, height: 2),
    /// - shadowRadius: 3
    static var light = ShadowStyle(
        shadowColor: UIColor.lightGray.cgColor,
        shadowOpacity: 0.5,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)

    /// Medium shadow style with:
    /// - shadowColor: UIColor.gray,
    /// - shadowOpacity: 0.6,
    /// - shadowOffset: CGSize(width: 0, height: 2),
    /// - shadowRadius: 3)
    static var medium = ShadowStyle(
        shadowColor: UIColor.gray.cgColor,
        shadowOpacity: 0.6,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)


    /// Dark shadow style with:
    /// - shadowColor: UIColor.darkGray,
    /// - shadowOpacity: 1.0,
    /// - shadowOffset: CGSize(width: 0, height: 2),
    /// - shadowRadius: 3)
    static var dark = ShadowStyle(
        shadowColor: UIColor.darkGray.cgColor,
        shadowOpacity: 1.0,
        shadowOffset: CGSize(width: 0, height: 2),
        shadowRadius: 3)
}
