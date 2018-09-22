//
//  StylingProtocols.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 20/09/2018.
//

import Foundation
import UIKit.UIColor

public protocol Stylable: class {
    /// - Foreground color
    /// - Color is used for example for image or text.
    var foregroundColorStylable: UIColor? { get set }

    /// - Background color
    /// - Color is used for example for background color or background image
    var backgroundColorStylable: UIColor? { get set }

    /// Controls the circular property on desired background view
    var circularStylable: Bool { get set }

    /// Layer to apply shadow to
    var shadowedLayerStylable: CALayer? { get }
}

// MARK: - SelectionElementStyling
/// Defines api for object resposible for styling SelectionElements.
public protocol SelectionElementStyling {
    /// Applies necessary styling to the given element.
    ///
    /// - Parameter element: SelectionElement styles should be applied to.
    /// - Parameter sectionType: SectionType of collection in which the element is contained
    /// - Parameter selected: Whether the given element is selected:
    ///     - For singleSelection the element is selected if it is the currently last selected one.
    ///     - For multiSeclection the element is selected if it is amongst selected selecetedIndexes.
    ///     - For buttonSelection the element is selected if it is highlighted.
    func apply(to element: SelectionElementView, in sectionType: SelectionMenu.SectionType, selected: Bool)
}

// MARK: - SelectionCollectionStyling
/// Defines api for object resposible for styling SelectionCollections.
public protocol SelectionCollectionStyling {
    /// Applies necessary styling to the given collection.
    func apply(to collection: SelectionCollectionView)
}
