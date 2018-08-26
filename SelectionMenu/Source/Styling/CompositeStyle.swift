//
//  CompositeStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 23/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

struct CompositeStyle {
    var elementStyles: [SelectionElementStyling]
    var collectionStyles: [SelectionCollectionStyling]

    init(elementStyles: [SelectionElementStyling] = [], collectionStyles: [SelectionCollectionStyling] = []) {
        self.elementStyles = elementStyles
        self.collectionStyles = collectionStyles
    }
}

// MARK: - SelectionElementStyling
extension CompositeStyle: SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool) {
        elementStyles.forEach { style in
            style.apply(to: element, selected: selected)
        }
    }
}

// MARK: - SelectionCollectionStyling
extension CompositeStyle: SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView) {
        collectionStyles.forEach { style in
            style.apply(to: collection)
        }
    }
}
