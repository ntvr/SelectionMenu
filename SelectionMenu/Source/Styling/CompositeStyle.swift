//
//  CompositeStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 23/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Universal style combining all passed styles and iterating over them when called.
public struct CompositeStyle {

    /// Combined SelectionElementStyling to apply when `apply(to:, selected:)` is called.
    public let elementStyles: [SelectionElementStyling]

    /// Combined SelectionCollectionStyling to apply when `apply(to:)` is called.
    public let collectionStyles: [SelectionCollectionStyling]

    /// Initializes CompositStyle.
    ///
    /// - Parameter elementStyles: Styles to apply when `apply(to:, selected:)` is called.
    /// - Parameter collectionStyles: Styles to apply when `apply(to:)` is called.
    public init(
        elementStyles: [SelectionElementStyling] = [],
        collectionStyles: [SelectionCollectionStyling] = [])
    {
        self.elementStyles = elementStyles
        self.collectionStyles = collectionStyles
    }
}

// MARK: - SelectionElementStyling
extension CompositeStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, in sectionType: SelectionMenu.SectionType, selected: Bool) {
        elementStyles.forEach { style in
            style.apply(to: element, in: sectionType, selected: selected)
        }
    }
}

// MARK: - SelectionCollectionStyling
extension CompositeStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {
        collectionStyles.forEach { style in
            style.apply(to: collection)
        }
    }
}
